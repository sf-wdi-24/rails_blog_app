class UsersController < ApplicationController

def new
	@user = User.new
end

def create
	user = User.new(user_params)
	user.valid?
	if user.save
		session[:user_id] = user.user.id 
		redirect_to '/'
	else
		# redirect_to '/signup'
		# save error message to flash[:error]
		flash[:error] = user.errors.full_messages.join(", ")
		redirect_to new_user_path
	end
end

private

def user_params
	params.require(:user).permit(:email, :password, :password_confirmation)
end


end




