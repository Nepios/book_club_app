class SessionsController < ApplicationController
  def new
  end
  
  def create
  @user = User.authenticate user_params[:email], user_params[:password]

  if @user
    session[:user_id] = @user.id
    flash[:success] = "Welcome back to ReadMe!"
    redirect_to root_path
  else
    flash[:danger] = "The email or password that you entered is invalid. Please enter a valid email and password to login."
    redirect_to login_path
  end
end

def destroy
  session[:user_id] = nil
  flash[:success] = "Until next time!"
  redirect_to root_path
end

private

def user_params
  params.require(:user).permit(:email, :password)
end
end
