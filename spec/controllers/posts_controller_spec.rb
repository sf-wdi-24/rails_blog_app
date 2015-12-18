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

        it "should add new post to the current user posts" do
          expect(@current_user.posts.count).to eq(@post_count + 1)
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

        it "should redirect_to 'new_post_path'" do
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

  describe "#edit" do
    context "logged" do
      context "trying edit user's own post" do
        before do
          @current_user = FactoryGirl.create(:user)
          session[:user_id] = @current_user.id
          @post = FactoryGirl.create(:post)
          @current_user.posts.push(@post)
          get :edit, id: @post.id
        end

         it "should assign @post" do
          expect(assigns(:post)).to eq(@post)
        end

        it "should render the :edit view" do
          expect(response).to render_template(:edit)
        end
      end
    end

    context "trying to edit another user's post" do
      before do
        # create and log in current_user
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
        
        another_user = FactoryGirl.create(:user)
        post = FactoryGirl.create(:post)
        another_user.posts.push(post)
        get :edit, id: post.id
      end

      it "should redirect_to 'login_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "#update" do 
    context "logged in" do
      before do
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
        #create a post
        @post = FactoryGirl.create(:post)
        #add to current user post
        @current_user.posts.push(@post)
        #edit that post
        get :edit, id: @post.id
      end

      context "successfully updated" do
        before do
          @new_title = FFaker::Lorem.words(5).join(" ")
          @new_content = FFaker::Lorem.paragraph 
          put :update, id: @post.id, post: {
            title: @new_title,
            content: @new_content
          }
          # reload @post to get changes from :update
          @post.reload
        end

        it "should update post in the current user posts" do
          expect(@post.title).to eq(@new_title)
          expect(@post.content).to eq(@new_content)
        end

        it "should redirect_to 'post_path'" do
          expect(response.status).to be(302)
          expect(response).to redirect_to(post_path(@post))
        end
      end

      context "validations failed" do
        before do
          put :update, id: @post.id, post: {
            title: nil,
            context: nil
          }
        end

        it "should display an error message" do
          expect(flash[:error]).to be_present
        end

        it "should redirect_to 'edit_post_path'" do
          expect(response).to redirect_to(edit_post_path(@post));
        end
      end
    end
    # need to do if non logged in
  end

  describe "destroy" do 
    context "logged in" do
      before do
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
        #create a post
        post = FactoryGirl.create(:post)
        #add to current user posts
        @current_user.posts.push(post)
        @posts_count = @current_user.posts.count
        #delete that post
        delete :destroy, id: post.id
      end

      it "should remove current_user's post from the database" do
        expect(@current_user.posts.count).to eq(@posts_count - 1)
      end

      it "should redirect_to 'posts_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(posts_path)
      end
    end

    #still need to do when user are not logged in
  end
end
