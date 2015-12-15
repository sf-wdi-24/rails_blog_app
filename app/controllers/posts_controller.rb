class PostsController < ApplicationController
  before_action :set_post, only:[:edit, :update, :show, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
      flash[:notice] = 'Post successfully created'
    else
      render :new
      flash[:alert] = 'Something went wrong, try again.'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = 'Post successfully updated'
    else
      render :edit
      flash[:alert] = 'Something went wrong, try again.'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:alert] = 'Post deleted'
  end

private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :user_id)
  end
end
