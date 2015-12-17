class PostsController < ApplicationController
  def new
    @post = Post.new
    # render :index
    render :new
  end

  def create
     post_params = params.require(:post).permit(:title, :story)
     post = Post.new(post_params)

     if post.save
        redirect_to post_path(post)
     else
      flash[:error] = post.errors.full_messages.join(", ")
        redirect_to new_post_path
      end
  end

  def update
    post_id = params[:id]
    post = Post.find_by_id(post_id)
    post_params = params.require(:post).permit(:title, :story)
    post.update_attributes(post_params)
    redirect_to post_path(post)
  end

  def edit
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
    render :edit
  end

  def destroy
    post_id = params[:id]
    post = Post.find_by_id(post_id)
    post.destroy
    redirect_to posts_path 
  end

  def index
    #get all posts from db and save to instance variable
    @posts = Post.all
    render :index
  end

  def show
    post_id = params[:id]
    @post = Post.find_by_id(post_id)
    redirect_to posts_path #changed to go to page of all posts
  end
end
