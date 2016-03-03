require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = create(:user)
    project = create(:project)
    @todo = Todo.new(content: 'some job')
    @todo.creator = @user
    @todo.project = project
  end

  it '创建todo时可以自动创建event 无指派完成人情况' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    event = Event.first
    expect(event.meta_data).to be(nil)
  end

  it '创建todo时可以自动创建event 有指派完成人情况' do
    executor = create(:user)
    @todo.executor = executor

    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    event = Event.first
    expect(event.meta_data['executor_name']).to eq(executor.username)
  end

  it '删除todo可以创建Event' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    expect{
      @todo.destroy!
    }.to change{Event.count}.by(1)
    event = Event.last
    expect(event.action).to eq('destroy_todo')
    expect(event.target_todo_content).to eq(@todo.content)
  end

  it '完成todo可以创建Event' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)
    closer = create(:user)
    expect{
      @todo.close!(closer)
    }.to change{Event.count}.by(1)
    event = Event.last
    expect(event.action).to eq('close_todo')
    expect(event.actor_name).to eq(closer.username)
  end

  it '重新修改任务完成时间可以创建Event 从没有截止时间到有截止时间' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    @todo.deadline = DateTime.now.tomorrow
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)
    @todo.reload

    event = Event.last

    expect(event.action).to eq('change_deadline')
    expect(DateTime.parse(event.to)).to eq(@todo.deadline)
  end

  it '重新修改任务完成时间可以创建Event 从有截止时间到有截止时间' do
    @todo.deadline = DateTime.now
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    @todo.reload
    before_deadline = @todo.deadline

    @todo.deadline = DateTime.now.tomorrow
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)
    @todo.reload

    event = Event.last

    expect(event.action).to eq('change_deadline')
    expect(DateTime.parse(event.to)).to eq(@todo.deadline)
    expect(DateTime.parse(event.from)).to eq(before_deadline)
  end

  it '重新指派任务可以创建Event' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    executor = create(:user)
    executor2 = create(:user)

    #指派任务给执行者1
    @todo.executor = executor
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    event = Event.last

    expect(event.action).to eq('change_executor')
    expect(event.from).to be(nil)
    expect(event.to).to eq(executor.username)

    #指派任务给执行者2
    @todo.executor = executor2
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    event = Event.last

    expect(event.action).to eq('change_executor')
    expect(event.from).to eq(executor.username)
    expect(event.to).to eq(executor2.username)
  end

  it '评论任务可以生成Event' do
    expect{
      @todo.save!
    }.to change{Event.count}.by(1)

    comment = Comment.new
    comment.todo = @todo
    comment.user = @user
    comment.content = '一些评论'
    expect{
      comment.save!
    }.to change{Event.count}.by(1)
    event = Event.last
    expect(event.meta_data['content']).to eq(comment.content)
    expect(event.actor_name).to eq(@user.username)
  end
end
