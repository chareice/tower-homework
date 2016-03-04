class SettingsController < ApplicationController
  before_action :require_login

  def show
    @team = Team.find(params[:team_id])
    @team_projects = @team.projects

    @current_user_projects = current_user.projects
  end

  def update
    current_user.projects.clear
    new_relation = Project.where(id: params[:projects])
    current_user.projects = new_relation
    redirect_to team_settings_path
  end
end
