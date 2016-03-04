require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  before do
    @user = create(:user)
    @project = create(:project)
    sign_in(@user)
  end

  describe '可以获取到某个项目的todo列表' do
    it '渲染index模版' do
      get :index, project_id: @project.id
      expect(response).to render_template(:index)
    end
  end

  describe '用户创建项目的todo' do
    it '可以访问新建todo页面' do
      get :new, project_id: @project.id
      expect(response).to render_template(:new)
    end

    it '用户未登录状态需要跳转到登录界面' do
      sign_out
      get :new, project_id: @project.id
      expect(response).to have_http_status(302)
    end

    it '可以创建todo' do
      executor = create(:user)
      content = '艰巨的任务'
      expect{
        post :create, project_id: @project.id, todo: {content: content, executor_id: executor.id}
      }.to change{Todo.count}.by(1)
    end

    it '可以修改todo' do
      @executor = create(:user)
      content = '艰巨的任务'
      expect{
        post :create, project_id: @project.id, todo: {content: content, executor_id: @executor.id}
      }.to change{Todo.count}.by(1)
      @todo = Todo.first

      patch :update, id: @todo.id, todo: {deadline: '2016-03-31'}
      expect(response).to have_http_status(302)
    end

    it '非任务创建者修改任务 Event记录的Actor应该为修改任务者' do
      @executor = create(:user)
      content = '艰巨的任务'
      expect{
        post :create, project_id: @project.id, todo: {content: content, executor_id: @executor.id}
      }.to change{Todo.count}.by(1)
      @todo = Todo.first
      sign_out
      sign_in @executor
      expect{
        patch :update, id: @todo.id, todo: {deadline: '2016-03-31'}
      }.to change{Event.count}.by(1)

      event = Event.last
      expect(event.actor_id).to eq(@executor.id)
    end

    it '可以完成todo' do
      @executor = create(:user)
      content = '艰巨的任务'
      expect{
        post :create, project_id: @project.id, todo: {content: content, executor_id: @executor.id}
      }.to change{Todo.count}.by(1)
      @todo = Todo.first

      patch :close, id: @todo.id
      @todo.reload
      expect(@todo.state).to eq('closed')
    end

    it '可以删除todo' do
      @executor = create(:user)
      content = '艰巨的任务'
      expect{
        post :create, project_id: @project.id, todo: {content: content, executor_id: @executor.id}
      }.to change{Todo.count}.by(1)
      @todo = Todo.first
      expect{
        delete :destroy, id: @todo.id
      }.to change{Todo.count}.by(-1)
    end
  end

end
