class ProjectsController < ApplicationController
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
    @project = Project.new(name: params[:name])
    @project.team = @team
    
    if @project.save
      redirect_to team_projects_path(@team)
    else
      render :new
    end
  end
end
