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
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = user.errors.full_messages.join(', ')
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
  end

  def update
    user_id = params[:id]
    @user = User.find_by_id(user_id)
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    user_id = params[:id]
    user = User.find_by_id(user_id)
    user.destroy
    session[:user_id] = nil
    redirect_to users_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
