class UsersController < ApplicationController
  def new
    if current_user
      redirect_to root_path
      flash[:alert] = 'You are already logged in'
    else
      render :new
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
      flash[:notice] = 'You have signed up!'
    else
      render :new
      flash[:alert] = 'Please do not leave anything blank, password must be longer than 6 characters'
    end
  end
private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
