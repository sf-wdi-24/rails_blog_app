class SessionsController < ApplicationController

	def new
		if current_user
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	def create
		if current_user
			redirect_to '/'
		else
			@user = User.find_by_email(user_params[:email])
			if @user && @user.authenticate(user_params[:password])
				session[:user_id] = @user.id
				flash[:notice] = "Logged In"
				redirect_to user_path(@user)
			else
				flash[:error] = "Incorrect email or password"
				redirect_to login_path
			end
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged Out"
		redirect_to login_path
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :name)
	end

end