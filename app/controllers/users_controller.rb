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
    user = User.new(user_params)
    if user.save
    	session[:user_id] = user.id
    	redirect_to '/'
    else
    	redirect_to '/signup'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  

  def show
  	user_id = params[:id]
  	@user = User.find_by_id(user_id)
  end

  end

  def destroy
  end



