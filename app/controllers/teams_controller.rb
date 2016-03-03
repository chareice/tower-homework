class TeamsController < ApplicationController
  before_action :require_login

  def index
    @teams = Team.all
    render :index
  end

  def new
    @team = Team.new
    render :new
  end

  def create
    @team = Team.new(name: params[:name])
    if @team.save
      redirect_to action: :index
    else
      render :new
    end
  end
end
