class UsersController < ApplicationController

  def index
    @users = User.all
	end

  def new
    @user = User.new
  end

  def create
		@user = User.new(user_params)
		if @user.save
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join(", ") 
      redirect_to new_user_path
    end
	end

  def edit
    user_id = params[:id]
    @user = User.find_by_id(user_id)
    render :edit
  end

  def update
    user_id = params[:id]
    @user = user.find_by_id(user_id)
    @user.update_attributes(user_params)
    if user.errors.any?
      flash[:error] = @user.errors.full_messages.join(", ") 
      redirect_to new_user_path
    else
      redirect_to edit_user_path(@user)
    end
  end

  def show
    user_id = params[:id]
    @user = User.find_by_id(user_id)
  end

  def destroy
    user_id = params[:id]
    User.find_by_id(user_id).destroy
    redirect_to root_path
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
  	
end
