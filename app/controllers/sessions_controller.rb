class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		# if user exists AND the password is entered correctly
		if user && user.authenticate(params[:password])
			# save the user id inside the browser cookie
			# this is how we keep user logged in
			session[:user_id] = @user.id
			flash[:notice] = "Successfully logged in"
			redirect_to user_path(@user)
		else
			# if user's login doesn't work, send to login form
			flash[:error] = "Incorrect email or password."
			redirect_to '/login'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Successfully logged out."
		redirect_to '/logout'
	end

	private

	def user_params
      params.require(:user).permit(:email, :password)
    end
end
