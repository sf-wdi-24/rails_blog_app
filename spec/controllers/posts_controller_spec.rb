require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	describe "#index" do
    before do
      @posts = Post.all
      get :index
    end

    it "should assign @posts" do
      expect(assigns(:posts)).to eq(@posts)
    end

    it "should render the :index view" do
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    context "logged in" do
      before do
        # create and log in current_user
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
        get :new
      end

      it "should assign @post" do
        expect(assigns(:post)).to be_instance_of(Post)
      end

      it "should render the :new view" do
        expect(response).to render_template(:new)
      end
    end

    context "not logged in" do
      before do
        get :new
      end

      it "should redirect to 'login_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "#create" do
    context "logged in" do
      before do
        # create and log in current_user
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
        get :new
      end

      context "successfully created" do
        before do
          @post_count = @current_user.posts.count

          post :create, post: {
            title: FFaker::Lorem.words(5).join(" "),
            content: FFaker::Lorem.paragraph 
          }
        end

        it "should add new post to the database" do
          expect(Post.count).to eq(@post_count + 1)
        end

        it "should redirect_to 'post_path'" do
          expect(response.status).to be(302)
          expect(response.location).to match(/\/posts\/\d+/)
        end
      end

      context "validations failed" do
        before do
          # make a post that failed all validation
          post :create, post: {
            title: nil,
            content: nil
          }
        end

        it "should display a error flash message" do
          expect(flash[:error]).to be_present
        end

        it "should redirect_to 'new_product_path'" do
          expect(response.status).to be(302)
          expect(response).to redirect_to(new_post_path)
        end
      end
    end

    context "non logged in" do
      before do
        post :create, post: { title: FFaker::Lorem.words(5).join(" "), content: FFaker::Lorem.paragraph }
      end

      it "should redirect to 'login_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "#show" do
    before do
      @post = FactoryGirl.create(:post)
      get :show, id: @post.id
    end

    it "should assign @post" do
      expect(assigns(:post)).to eq(@post)
    end 

    it "should render the :show view" do
      expect(response).to render_template(:show)
    end
  end

end
