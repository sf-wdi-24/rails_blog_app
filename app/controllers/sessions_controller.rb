class SessionsController < ApplicationController

def new
end

def create
	user = User.find_by_email(params[:email])
	#if the user exists
	if user && user.authenticate(params[:password])
		#save the user id
		session[:user_id] = user.id
		# redirect_to '/'
  else
  	#if user login doesn't work
  	flash[:error] = "here is some text"
  	redirect_to '/login'
  end
end

def destroy
	session[:user_id] = nil
	redirect_to '/login'
end

end