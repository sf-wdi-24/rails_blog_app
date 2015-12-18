class PostsController < ApplicationController
  before_filter :set_post, except: [:index, :new, :create]
  before_filter :authorize, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      redirect_to new_post_path
    end
  end

  def show
  end

  def edit
    unless current_user == @post.user
      redirect_to user_path(current_user)
    end
  end

  def update
    if current_user == @post.user
      if @post.update_attributes(post_params)
        redirect_to post_path(@post)
      else
        flash[:error] = @post.errors.full_messages.join(", ")
        redirect_to edit_post_path(@post)
      end
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      redirect_to root_path
    end
  end

private

  def set_post
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
