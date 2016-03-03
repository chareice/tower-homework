class TodosController < ApplicationController
  before_action :require_login

  def new
    @todo = Todo.new
    @project = Project.where(id: params[:project_id]).includes(:users).first
  end

  def index
    @project = Project.find(params[:project_id])
    @todos = @project.todos
  end

  def create
    @project = Project.find(params[:project_id])

    @todo = Todo.new(todo_params)
    @todo.creator = current_user
    @todo.project = @project
    if @todo.save
      redirect_to project_todos_path(project_id: @project.id)
    else
      render 'new'
    end
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
