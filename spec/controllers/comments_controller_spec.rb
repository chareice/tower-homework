require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = create(:user)
    @project = create(:project)
    sign_in(@user)

    @todo = Todo.new(content: 'some job')
    @todo.creator = @user
    @todo.project = @project
    @todo.save!
  end

  it '可以获取到todo的comments' do
    get :index, todo_id: @todo.id
    expect(response).to have_http_status(200)
  end

  it '可以创建评论' do
    expect{
      post :create, todo_id: @todo.id, comment: {content: '做完了'}
    }.to change{Comment.count}.by(1)
  end
end
