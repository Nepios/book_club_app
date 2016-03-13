class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:success] = 'Thank you for signing up!'
    session[:user_id] = user.id #logs the newly registered user in automatically
    redirect_to root_path
  end

  def profile
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
