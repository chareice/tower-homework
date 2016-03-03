class CommentsController < ApplicationController
  def index
  end

  def create
    @todo = Todo.find(params[:todo_id])
    comment = Comment.new
    comment.content = params[:comment][:content]
    comment.user = current_user
    comment.todo = @todo
    if comment.save
      redirect_to todo_comments_path(todo_id: @todo.id) and return
    else
      redirect_to todo_comments_path(todo_id: @todo.id) and return
    end
  end

end
