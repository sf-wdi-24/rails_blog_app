require 'rails_helper'

RSpec.describe Post, type: :model do
    before do
		post_params = Hash.new
		post_params[:title] = FFaker::Lorem.words(2).join
		post_params[:content] = FFaker::Lorem.words(5).join
		@post = Post.create(post_params)
	end

	describe "#post title attributes" do
	    it "title should match title " do
	      expect(@post.title).to eq("#{@post.title}")
	    end
	    it "content should be longer than 2 characters" do
	    	expect(@post.title.length).to be > 2
	    end
  	end

 	describe "#post content attributes" do
	    it "content should match content " do
	      expect(@post.content).to eq("#{@post.content}")
	    end
	    it "content should be longer than 9 characters" do
	    	expect(@post.content.length).to be > 9
	    end
  	end
end