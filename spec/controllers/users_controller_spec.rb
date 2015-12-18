require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    before do
      @all_users = User.all
      get :index
    end


    it "should assign @users" do
      expect(assigns(:users)).to eq(@all_users)
    end

    it "should render :index view" do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    context "not logged in" do
      before do
        get :new
      end

      it "should assign @user" do
        get :new
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "should render :new view" do
        expect(response).to render_template(:new)
      end
    end

    context "logged in" do
      before do
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id

        get :new
      end

      it "should redirect to user page" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(user_path(@current_user))
      end
    end

  end

  describe "#create" do
    context "success" do
      before do
        @users_count = User.count
        post :create, user: { email: FFaker::Internet.email, password: FFaker::Lorem.words(5).join }
      end

      it "should add new user to the database" do
        expect(User.count).to eq(@users_count + 1)
      end

      it "should redirect_to user page" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/users\/\d+/)
      end
    end

    context "failure" do
      before do
        post :create, user: {email: nil, password: nil }
      end

      it "should display error message" do
        expect(flash[:error]).to be_present
      end

      it "should redirect to signup page" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(:users_new)
      end
    end
    context "logged in" do
      before do
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id

        post :create, user: { email: FFaker::Internet.email, password: FFaker::Lorem.words(5).join }
      end
        it "should redirect to user page" do
          expect(response.status).to be(302)
          expect(response).to redirect_to(user_path(@current_user))
        end
      end
    end

    describe "#show" do
      before do
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id

        get :show, id: @current_user.id
      end

      it "should assign @user" do
        expect(assigns(:user)).to eq(@current_user)
      end

      it "should render the show view" do
        expect(response).to render_template(:show)
      end
    end

    describe "#edit" do
      context "logged in" do
        before do
          @current_user = FactoryGirl.create(:user)
          session[:user_id] = @current_user.id

          get :edit, id: @current_user.id
        end

        it "should assign @user" do
          expect(assigns(:user)).to eq(@current_user)
        end

        it "should render edit view" do
          expect(response).to render_template(:edit)
        end
      end

      context "not logged in" do
        before do
          user = FactoryGirl.create(:user)

          get :edit, id: user.id
        end

        it "should redirect to 'login_path'" do
          expect(response.status).to be(302)
          expect(response).to redirect_to(login_path)
        end
      end

      context "trying to edit another user" do
        before do
          @current_user = FactoryGirl.create(:user)
          session[:user_id] = @current_user.id

          another_user = FactoryGirl.create(:user)
          get :edit, id: another_user.id
        end

        it "should redirect_to 'user_path'" do
          expect(response.status).to be(302)
          expect(response).to redirect_to(user_path(@current_user))
        end
      end
    end

end




 
