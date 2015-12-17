class SessionsController < ApplicationController
	def new
		if current_user
			redirect_to users_path
		end
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to users_path
		else
			flash[:error] = "Incorrect login email or password"
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end
end
