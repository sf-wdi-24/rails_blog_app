class UsersController < ApplicationController
	before_filter :set_user, except: [:index, :new, :create]

	def index
		@users = User.all
	end
	def new 
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Signed Up!"
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages.join(", ")
			redirect_to signup_path
		end
	end
	def show
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:notice] = "Updated profile!"
			redirect_to edit_user_path(@user)
		else
			flash[:error] = @user.errors.full_messages.join(", ")
			redirect_to edit_user_path(@user)
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		flash[:notice] = "Deleted!"
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
	def set_user
		user_id = params[:id]
		@user = User.find_by_id(user_id)
	end
end
