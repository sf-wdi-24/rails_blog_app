class PostsController < ApplicationController

  #before_filter :authorize

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      redirect_to new_post_path
    end
  end

  def update
    @post = Post.find(params[:id])
    post_params = params.require(:post).permit(:title, :content)
    if @post.update_attributes(post_params) && @post.user_id == current_user.id
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      redirect_to edit_post_path
    end
  end

  def edit
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      @post = post
    else
      redirect_to '/posts'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy && @post.user_id == current_user.id
        redirect_to posts_path, notice: "Post deleted."
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
