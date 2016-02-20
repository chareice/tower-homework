require 'rails_helper'

RSpec.describe Todo, type: :model do
  before do
    @todo = Todo.new
    @todo.content = '一些复杂而艰巨的任务'
  end

  it '可以创建任务' do
    user = create(:user)
    expect{
      @todo.creator = user
      @todo.save
    }.to change{Todo.count}.by(1)

    expect(@todo.state).to eq('opened')
  end

  it '任务是属于某个项目的' do
    project = create(:project)
    expect(project.todos).to be_empty

    creator = create(:user)
    executor = create(:user)

    @todo.creator = creator
    @todo.project = project
    @todo.save

    expect(project.todos).to include(@todo)
    expect(@todo.project).to be(project)
  end

  it '任务可以分配' do
    creator = create(:user)
    executor = create(:user)

    @todo.creator = creator
    @todo.save

    @todo.assign_executor!(executor)
    expect(@todo.executor).to eq(executor)
    expect(executor.jobs).to include(@todo)
  end

  it '任务可以完成' do
    creator = create(:user)
    executor = create(:user)

    @todo.creator = creator
    @todo.save
    @todo.assign_executor!(executor)

    @todo.close!
    expect(@todo.state).to eq('closed')
  end

  it '任务可以重新被打开' do
    creator = create(:user)
    executor = create(:user)

    @todo.creator = creator
    @todo.save
    @todo.assign_executor!(executor)

    @todo.close!
    expect(@todo.state).to eq('closed')
    @todo.reopen!
    expect(@todo.state).to eq('opened')
  end
end
