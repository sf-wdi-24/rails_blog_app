class UsersController < ApplicationController
	def new
	end

	def create
		if current_user
			redirect_to user_path(current_user)
		else
		@user = User.new(user_params)
			if @user.save
				session[:user_id] = @user.id 
				flash[:notice] = "Signed up"
				redirect_to '/'
			else
				redirect_to '/signup'
			end
		end	
	end

private
	
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end
