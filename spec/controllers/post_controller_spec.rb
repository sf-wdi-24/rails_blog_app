require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	describe "#index" do
		before do
			@all_posts = Post.all
			get :index
		end

		it "shoul assign @posts" do 
			expect(assigns(:posts)).to eq(@all_posts)
		end

		it "should render index view" do
			expect(response).to render_template(:index)
		end
	end

	describe "#new" do
		before do
			get :new
		end

		it "should render :new view" do
			expect(response).to render_template(:new)

		end

		it "should render the :new view" do
      		expect(response).to render_template(:new)
    	end

    	# need to write a test to unlogged user
	end

	describe "#create" do
		context "success" do
			before do
				@post_title = "abcde"
				@post_content = "asdfghjjk"
				post :create, post: {
					title: "asdfg"
					content: "dslknkdsldjldsjldskjdlsk"
				}
			end

		it "should add new post to db" do
			
			



end
