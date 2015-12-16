class UsersController < ApplicationController
  def index
    # getting all users and saving to instance variable
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    end
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    render :show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end


private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation)
  end
