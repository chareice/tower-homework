require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '可以创建评论' do
    user = create(:user)
    project = create(:project)

    todo = Todo.new(content: 'some job')
    todo.creator = user
    todo.project = project
    todo.save!

    expect(todo.comments).to be_empty

    comment = Comment.new
    comment.todo = todo
    comment.user = user
    comment.content = '一些评论'
    comment.save!
    expect(todo.comments).to include(comment)
  end
end
