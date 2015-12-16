class UsersController < ApplicationController

	def index
	end

	def new
		@user = User.new
	end

	def create

		@user = User.new(user_params) 
		@user.valid?
		if @user.save
			session[:user_id] = @user.id
			redirect_to '/'
		else
			flash[:error] = @user.errors.full_messages.join(', ')
			redirect_to '/users/new'
		end
	end

	def edit
	end

	def login
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
