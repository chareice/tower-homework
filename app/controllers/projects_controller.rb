class ProjectsController < ApplicationController
  before_action :require_login

  def index
    @team = Team.find(params[:team_id])
    render :index
  end

  def new
    @team = Team.find(params[:team_id])
    @project = Project.new
    render :new
  end

  def create
    @team = Team.find(params[:team_id])
    @project, res = current_user.create_project(params[:name], @team)
    if res
      redirect_to team_projects_path(@team)
    else
      render :new
    end
  end
end
