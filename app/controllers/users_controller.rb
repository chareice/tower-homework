class UsersController < ApplicationController
  def new
    @user = User.new
    render 'new'
  end

  def create
    @user = User.new(email: params[:email], password: params[:password])
    if @user.save
      render text: 'nothing'
    else
      render :new
    end
  end

end
