class UsersController < ApplicationController
  before_filter :set_user, except: [:index, :new, :create]
  before_filter :authorize, only: [:edit, :update, :destroy]

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
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to signup_path
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user == @user
      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to edit_user_path(@user)
      end
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    if current_user == @user
      @user.destroy
      session[:user_id] = nil
      redirect_to login_path
    else
      redirect_to user_path(current_user)
    end
  end

private

  def set_user
    user_id = params[:id]
    @user = User.find_by_id(user_id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
