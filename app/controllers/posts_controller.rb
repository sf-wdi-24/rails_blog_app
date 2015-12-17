class PostsController < ApplicationController
  
  before_action :get_post_id #, only:[:index, :show, :edit, :update, :destroy]

  def index
  	@posts = (Post.all).order(created_at: :desc)
  end

  def new
  	@post = Post.new
  end

  def create
  	if current_user
  		@post = current_user.posts.new(post_params)
  		@post.valid?
  			if @post.save
  				redirect_to post_path(@post)
  			else
  				flash[:error] = @post.errors.full_messages.join(', ')
  				redirect_to new_post_path
  			end
  	else
  		flash[:error] = "You must be logged in to make a post"
  		redirect_to login_path
  	end
  end

  def show
  	# if current_user == @user_id
  	# 	render :show
  	# else
  	# 	redirect_to login_path
  	# end
  end

  def edit
  	unless current_user == @post.user
  		flash[:notice] = "Only #{@post.user.name} has access to edit this post"
  		redirect_to root_path
  	end
  end

  def update
  	if current_user == @post.user
  		if @post.update_attributes(post_params)
  			flash[:notice] = "You have updated your post"
  			redirect_to post_path(@post)
  		else
  			flash[:error] = @post.errors.full_messages.join(", ")
  			redirect_to edit_post_path(@post)
  		end
  	else
  		flash[:notice] = "You do not have access to edit this page :("
  		redirect_to root_path
  	end
  end

  def destroy
  	if current_user == @post.user
  		@post.destroy
  		flash[:notice] = "You have removed your post"
  	else
  		flash[:error] = "You cannot remove this post"
  	end
  	redirect_to root_path
  end

  private

  def post_params
  	params.require(:post).permit(:title, :content)
  end

  def get_post_id
  	@post = Post.find_by_id(params[:id])
  end

end
