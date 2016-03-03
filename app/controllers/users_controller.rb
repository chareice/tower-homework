class UsersController < ApplicationController
  def new
    @user = User.new
    render 'new'
  end

  def create
    @user = User.new(email: params[:email], password: params[:password])
    @user.username = params[:username]
    if @user.save
      redirect_to teams_path
    else
      render :new
    end
  end

end
