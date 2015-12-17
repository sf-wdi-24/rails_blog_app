class PostsController < ApplicationController
  
  def index
    #get all posts
    @posts = Post.all
  end

  def new
    # prevent non logged in user to see new post form
    if current_user
      @post = Post.new()
    else
      redirect_to login_path
    end
  end

  def create
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
  end

  def update
  end

  def destroy
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
