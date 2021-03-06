class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_login
    unless current_user
      redirect_to(new_session_path(redirect_url: request.original_url))
    end
  end
end
