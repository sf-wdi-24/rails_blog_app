class PostsController < ApplicationController

	def index
		@posts = Post.all
		render :index
	end

	def new
		@post = Post.new
		render :new
	end

	def create
		post_params = params.require(:post).permit(:title, :description)
		post = Post.new(post_params)

		if post.save
			redirect_to post_path(post)
		end
	end

	def show
		post_id = params[:id]

		@post = Post.find_by_id(post_id)
		render :show
	end

	def edit
		post_id = params[:id]
		@post = Post.find_by_id(post_id)
		render :edit
	end

	def update
		post_id = params[:id]
		post = Post.find_by_id(post_id)
		post_params = params.require(:post).permit(:title, :description)
		post.update_attributes(post_params)
		redirect_to post_path(post)
	end

	def destroy
		post_id = params[:id]
		post = Post.find_by_id(post_id)
		post.destroy
		redirect_to posts_path
	end

end
