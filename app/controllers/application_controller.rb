class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user = User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = current_user.reset_session_token!
    #it will set the current session token to equal a new reset version of the user's session token
    #define logout
  end 

  def logout_user
    #logout will first check if user is logged in
    #then it will reset session token
    #then it will sert session token to equal nil
    #then it will set @current_user to nil
    current_user.reset_session_token! if logged_in? 
    session[:session_token] = nil
    @current_user = nil 
  end

  def require_logged_in
    redirect_to new_sessions_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end
  

end