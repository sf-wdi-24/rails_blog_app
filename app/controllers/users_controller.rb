class UsersController < ApplicationController

  before_filter :authorize, except: [:new]
  before_filter :current_user_logged_in, except: [:index, :show, :edit]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:name, :email, :password)
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to edit_user_path
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
        redirect_to signup_path, notice: "User deleted."
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
