class UsersController < ApplicationController
  
  def index
    @users = User.all
    render :index
  end
  
  def new
    @user = User.new
    render :new
  end

  def edit
  end

  def update
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    user = User.new(user_params)
    if user.save
      redirect_to '/posts'
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to '/signup'
    end
  end



  private

  def show
  	user_id = params[:id]
  	@user = User.find_by_id(user_id)
  end

  end

  def destroy
  end



