class UsersController < ApplicationController
	before_filter :set_user, except: [:index, :new, :create]

	def index
		@users = User.all
	end	
		
	def new
		if current_user
			redirect_to user_path(current_user)
		else
		@user = User.new
		end
	end

	def create
		if current_user
			redirect_to user_path(current_user)
		else
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user_id
			flash[:notice] = 'Successfully signed in.'
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages.join(', ')
			redirect_to '/login'
		end
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:notice] = 'Successfully updated profile'
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages.join(', ')
			redirect_to edit_user_path(@user)
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		flash[:notice] = 'Successfully deleted profile.'
		redirect_to '/login'
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end	

	def set_user
		user_id = params[:id]
		@user = User.find_by_id(user_id)
	end

end
