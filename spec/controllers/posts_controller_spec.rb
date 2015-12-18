require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do
    before do
      @all_posts = Post.all
      get :index
    end
    it "should assign @post" do
      expect(assigns(:posts)).to eq(@all_posts)
    end

    it "should render :index view" do
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it "should assign @post" do
      expect(assigns(:post)).to be_instance_of(Post)
    end

    it "should render the :new view" do
      expect(response).to render_template(:new)
    end
  end

  

end
