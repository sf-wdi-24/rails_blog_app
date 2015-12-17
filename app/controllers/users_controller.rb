class UsersController < ApplicationController
	attr_reader :name


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
			flash[:notice] = "You have signed up"
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages.join(', ')
			redirect_to new_user_path
		end
	end

	def show
		user_id = params[:id]
		@user = User.find_by_id(user_id)
	end

	def edit
		user_id = params[:id]
		@user = User.find_by_id(user_id)
		if current_user == @user
			render :edit
		else
			flash[:error] = "Please login to edit users"
			redirect_to edit_user_path(current_user)
		end
	end

	def update
		user_id = params[:id] 
		@user = User.find_by_id(user_id)
		if current_user == @user
			if @user.update_attributes(user_params)
				flash[:notice] = "You have updated your profile"
				redirect_to user_path(@user)
			else
				flash[:error] = @user.errors.full_messages.join(", ")
				redirect_to edit_user_path(@user)
			end
		else
			flash[:notice] = "You do not have access to edit this page :("
			redirect_to root_path
		end
	end

	def destroy
		user_id = params[:id] 
		@user = User.find_by_id(user_id)
		if current_user == @user
			@user.destroy
			session[:user_id] = nil
			flash[:notice] = "You have deleted your profile"
			redirect_to root_path
		else
			flash[:error] = "You do not have access to delete this profile"
			redirect_to root_path

		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :name)
	end

end
