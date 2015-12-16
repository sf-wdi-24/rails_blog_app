class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path
      flash[:alert] = 'You are logged in -_-'
    else
      render :new
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
      flash[:notice] = 'Welcome back'
    else
      redirect_to '/login'
      flash[:alert] = 'Credentials are not correct, try again'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:alert] = 'Logged out.'
  end
end
