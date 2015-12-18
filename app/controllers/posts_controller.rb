class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post)
    else
      flash[:error] = post.errors.full_messages.join(', ')
      redirect_to new_post_path
    end
  end

  def show
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
  end

  def edit
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
    unless current_user.id == @post.user_id
      redirect_to post_path(@post)
      flash[:notice] = "You cannot edit other user's posts!"
    end
  end

  def update
    post_id = params[:id]
    post = Post.find_by_id(post_id)
    if current_user.id == post.user_id
      if post.update_attributes(post_params)
        redirect_to post_path(post)
      else
        flash[:error] = post.errors.full_messages.join(', ')
        redirect_to edit_post_path(post)
      end
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    post_id = params[:id]
    post = Post.find_by_id(post_id)
    if current_user.id == post.user_id
      post.destroy
      redirect_to posts_path
    else
      flash[:notice] = "You cannot delete other user's posts!"
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
