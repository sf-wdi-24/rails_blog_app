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
			flash[:notice] = "Successfully created new post."
			redirect_to post_path(@post)
		else
			flash[:error] = @post.errors.full_messages.join(", ")
			redirect_to new_post_path
		end
	end

	def show
	end

	def edit
		# user can only see own posts in edit view
		unless current_user == @post.current_user
			redirect_to user_path(current_user)
		end
	end

	def update
		# user can only update own posts
		if current_user == @post.user
			if @post.update_attributes(post_params)
				flash[:notice] = "Successfully updated post."
				redirect_to post_path(@post)
			else
				flash[:notice] = @post.errors.full_messages.join(", ")
				redirect_to edit_post_path(@post)
			end
		else
			redirect_to user_path(current_user)
		end
	end

	def destroy
		# only let the user delete their own posts
		if current_user == @post.user
			@post.destroy
			flash[:notice] = "Successfully deleted post."
		end
		redirect_to user_path(current_user)
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end

	def set_post
		post_id = params[:id]
		@post = Post.find_by_id(post_id)
	end

end
