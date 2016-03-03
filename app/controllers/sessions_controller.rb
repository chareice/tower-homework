class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.auth(params[:email],params[:password])
    if user
      sign_in user
      if params[:redirect_url]
        redirect_to(params[:redirect_url]) and return
      else
        redirect_to(teams_path) and return
      end
    else
      render text: 'not auth' and return
    end
  end
end
