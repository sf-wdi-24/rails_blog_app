class SessionsController < ApplicationController
  
  def new
    #prevent current user to see login view
    if current_user
      redirect_to user_path(current_user)
    end
	end
	
	def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
  
end
