module SessionsHelper
  def sign_in(user)
    session[:userid] = user.id
    @current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if @current_user != session[:userid]
      @current_user = User.find_by id:session[:userid]
    end
    @current_user
  end

  def sign_out
    @current_user = nil
    session[:userid] = nil
  end

end
