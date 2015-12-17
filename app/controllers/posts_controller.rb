class PostsController < ApplicationController
  def index
    @posts = Post.all
    render :index
  end

  def new
    if current_user
      render :new
    else
      retirect_to login_path
    end

  end

  def create
    if current_user
      post_params = params.require(:post).permit(:title, :content)
      post=current_user.posts.new(post_params)
      if post.save
        redirect_to posts_path
      else
        flash[:error] = post.errors.full_messages.join(", ")  
        redirect_to new_post_path
      end
    end
  end

  def show
    post_id = params[:id]
    @post = Post.find(post_id)
    render :show
  end

  def edit
      post_id = params[:id]
      @post = Post.find(post_id)
    if (@post.user_id).to_i == (current_user.id).to_i
      render :edit
    else
       flash[:error]="YOU CAN'T EDIT IT"
       redirect_to posts_path
    end
  end

  def update

    post_id = params[:id]
    post = Post.find(post_id)
    post_params =  post_params = params.require(:post).permit(:title, :content)
    if post.update_attributes(post_params)
      redirect_to post_path(post)
    else
      flash[:error] = post.errors.full_messages.join(", ")
      redirect_to edit_post_path(post)
    end
  end

  def destroy
    post_id = params[:id]
    post = Post.find(post_id)
    if (post.user_id).to_s == (current_user.id).to_s
      post.destroy
    else
      flash[:error]="YOU CAN'T DELETE IT"
    end  
    redirect_to posts_path
  end
end
