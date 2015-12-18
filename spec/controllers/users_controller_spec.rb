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
	    		expect(assigns(:users)).to eq(@all_users)
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
	    		expect(response).to redirect_to(user_path(@current_user))
	    	end
	    end

    end

    describe "GET #create" do
    	context "success" do
    		before do
    			@users_count = User.count
    		end

    		it "should add new user to database" do
    			expect(User.count).to eq(@users_count)
    		end

    		it "should redirect to user page" do
    			expect(response).to redirect_to(user_path(@current_user))
	    	end
	    end
	end


end
