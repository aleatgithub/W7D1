class SessionsController < ApplicationController

  before_action :require_logged_in, only:[:index, :show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user.save #if user exists
      ##log them in
     redirect_to user_url(@user)
     else 
      #we think this is all we need
      render :new
      redirect_to cats_url
    end


  end

  def destroy
    current_user.reset_session_token! if current_user.session_token == self.session_token
  end

end
