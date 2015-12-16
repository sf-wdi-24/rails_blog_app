class UsersController < ApplicationController

	# before_filter :authorize

	def index
		@users = User.all
		render :index
	end

	def new
		render :new
	end

	def create
		user_params = params.require(:user).permit(:email, :password)
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to users_path(user)
		else
			flash[:error] = user.errors.full_messages.join(", ")	
      		redirect_to new_user_path
		end
	end

	def show
		user_id = param[:id]
		@user = User.find(user_id)
		render :show
	end

	def edit
		user_id = param[:id]
		@user = User.find(user_id)
		render :edit
	end

	def update
		user_id = param[:id]
		user = User.find(user_id)
		user_params = params.require(:user).permit(:email, :password)
		user.update_attribues(user_params)
		if user.update
			redirect_to user_path(user)
		else
			flash[:error] = user.errors.full_messages.join(", ")
			redirect_to edit_user_path(user)
		end
	end

	def destroy
		user_id = params[:id]
		user = User.find(user_id)
		user.destroy
		redirect_to users_path
	end

	# private

	#   def user_params
	    
	#   end
end