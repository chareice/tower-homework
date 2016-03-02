class TodosController < ApplicationController
  before_action :require_login

  def index
  end

  def create
    todo = Todo.new(todo_params)
    todo.creator = current_user
    todo.project_id = params[:project_id]
    todo.save!
    redirect_to project_todos_path(project_id: params[:project_id])
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes!(todo_params)
    redirect_to todo_path(todo)
  end

  private
  def todo_params
    params.require(:todo).permit(:executor_id, :content, :deadline)
  end
end
