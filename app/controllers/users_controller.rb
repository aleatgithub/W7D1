class UsersController < ApplicationController
  before_action :require_logged_in,
    only:[:index] #come back here

  def index
    @users = User.all 
    render :index
  end
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      #add flash
      render :new
    end
  end

  def edit 
    @user = User.find(params[:id])
    render :edit
  end


  private 
  def user_params
    params.require(:user).permit(:user_name, :password_digest)
  end
end
