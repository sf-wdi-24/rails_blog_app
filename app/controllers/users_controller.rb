class UsersController < ApplicationController

	before_filter :authorize, except: [:new, :create]

	def index
		@users = User.all
		render :index
	end

	def new
		if current_user
			redirect_to posts_path(current_user)
		else
			render :new
		end
	end

	def create
		if current_user
			redirect_to posts_path(current_user)
		else
			user_params = params.require(:user).permit(:email, :password)
			user = User.new(user_params)
			if user.save
				session[:user_id] = user.id
				redirect_to posts_path
			else
				flash[:error] = user.errors.full_messages.join(",")	
	      		redirect_to new_user_path
			end
		end
	end

	def show
		user_id = params[:id]
		@user = User.find(user_id)
		render :show
	end

	def edit
		user_id = params[:id]
		@user = User.find(user_id)
		render :edit
	end

	def update
		user_id = params[:id]
		user = User.find(user_id)
		user_params = params.require(:user).permit(:email, :password)
		if user.update_attributes(user_params)
			redirect_to posts_path(user)
		else
			flash[:error] = user.errors.full_messages.join(", ")
			redirect_to edit_user_path(user)
		end
	end

	def destroy
		user_id = params[:id]
		user = User.find(user_id)
		if current_user == user
			session[:user_id] = nil
			flash[:notice]="success"
			user.destroy
		
		else
			flash[:error]="YOU CAN'T"
		end
		redirect_to users_path
	end

end