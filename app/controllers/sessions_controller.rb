class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.auth(params[:email],params[:password])
    if user
      sign_in user
      redirect_to(teams_path) and return
    else
      render text: 'not auth' and return
    end
  end
end
