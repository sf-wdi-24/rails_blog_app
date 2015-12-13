class CommentsController < ApplicationController
  before_filter :set_post
  before_filter :set_comment, except: [:new, :create]
  before_filter :authorize

  def new
    @comment = Comment.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      post_id = params[:post_id]
      @post = Post.find_by_id(post_id)
    end

    def set_comment
      comment_id = params[:id]
      @comment = Comment.find_by_id(comment_id)
    end

end