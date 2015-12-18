class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only:[:edit, :update, :destroy]
  before_action :authorize

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @post.comments << @comment
    if @comment.save
      redirect_to post_path(@post)
      flash[:notice] = 'Comment has been successfully added.'
    else
      redirect_to new_post_comment(@post)
      flash[:alert] = @comment.errors.full_messages.join(", ")
    end
  end

  def edit
    unless current_user == @comment.user
      redirect_to root_path
    end
  end

  def update
    if current_user.id == @comment.user.id
      if @comment.update(comment_params)
        redirect_to post_path(@post)
        flash[:notice] = 'Comment successfully updated'
      else
        redirect_to edit_post_comment(@post, comment)
        flash[:alert] = @comment.errors.full_messages.join(", ")
      end
    else
      edirect_to to root_path
    end
  end

  def destroy
    if current_user.id == @comment.user.id
      @comment.destroy
      redirect_to root_path
      flash[:notice] = "successfully deleted comment."
    else
      redirect_to post_path(@post)
    end
  end

private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

end
