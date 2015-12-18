require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	before do
		user_params = Hash.new
		user_params[:name] = FFaker::Name.first_name
		user_params[:email] = FFaker::Internet.email
		password = FFaker::Lorem.words(2).join
		user_params[:password] = password
		user_params[:password_confirmation] = user_params[:password]
		@user = User.create(user_params)
		User.where(:login => {email: @user.email, password: password})
		session[:user_id] = @user.id
		@current_user = @user
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
	end

	describe "GET #index" do
      it "should assign @posts" do
        all_posts = Post.where(user_id: @current_user.id)
        get :index
        expect(assigns(:posts)).to eq(all_posts)
      end

      it "should render the :index view" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET #new" do
      it "should assign @post" do
        get :new
        expect(assigns(:post)).to be_instance_of(Post)
      end

      it "should render the :new view" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "GET #show" do
      it "should assign @post" do
      	@post = Post.new({title: 'blah', content: 'blah'})
      	@post.save
        get :show, id: @post.id
        expect(assigns(:post)).to be_instance_of(Post)
      end

      it "should render the :show view" do
      	@post = Post.new({title: 'blah', content: 'blah'})
      	@post.save
        get :show, id: @post.id
        expect(response).to render_template(:show)
      end
    end

    describe "POST #create" do
      context "success" do
        it "should add new post to current_user" do
          posts_count = @user.posts.count
          post :create, post: {title: "blah", content: "blah"}
          expect(@user.posts.count).to eq(posts_count + 1)
        end

        it "should redirect_to 'post_path' after successful create" do
          post :create, post: {title: "blah", content: "blah"}
          expect(response.status).to be(302)
          expect(response.location).to match("http://test.host/posts/new")
        end
      end

      context "failure" do
        it "should redirect to 'new_post_path' when create fails" do
          post :create, post: { title: nil, content: nil}
          expect(response).to redirect_to(new_post_path)
        end
      end
    end

end