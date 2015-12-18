class PostsController < ApplicationController
  
  def index
    #get all posts
    @posts = Post.all
  end

  def new
    # prevent non logged in user to see new post form
    if current_user
      @post = Post.new
    else
      redirect_to login_path
    end
  end

  def create
    # prevent non logged in user to create post
    if current_user
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to post_path(@post)
      else
        flash[:error] = @post.errors.full_messages.join(', ')
        redirect_to new_post_path
      end
    else
      redirect_to login_path
    end
  end

  def show
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
  end

  def edit
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
    # prevent user to see other user's edit form
    unless current_user == @post.user
      redirect_to login_path
    end
  end

  def update
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
    # prevent user to edit other user's post
    if current_user == @post.user
      post_id = params[:id]
      @post = Post.find_by_id(post_id)
      if @post.update_attributes(post_params)
        redirect_to post_path(@post)
      else
        flash[:error] = @post.errors.full_messages.join(', ')
        redirect_to edit_post_path(@post)
      end
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    if current_user
      post_id = params[:id]
      @post = Post.find_by_id(post_id)
      # prevent user to delete other user's post
      if current_user == @post.user
        @post.destroy
        redirect_to posts_path
      else
        flash[:error] = "You can't delete other user's post!"
        redirect_to post_path(@post)
      end
    else 
      redirect_to login_path
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
