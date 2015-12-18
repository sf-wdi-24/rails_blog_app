require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "#index" do
		before do
			@users = User.all
			get :index
		end

		it "should assign @users" do
			expect(assigns(:users)).to eq(@users)
		end

		it "should render the :index view" do
			expect(response).to render_template(:index)
		end
	end

	describe "#new" do
		before do
			get :new
		end

		it "should assign @user" do
			expect(assigns(:user)).to be_instance_of(User)
		end

		it "should render the :new view" do
			expect(response).to render_template(:new)
		end
	end

	describe "#create" do
		context "success" do
			before do
				@users_count = User.count

				password = FFaker::Internet.password

				post :create, user: {
					name: FFaker::Name.first_name,
			    email: FFaker::Internet.email,
			    password: password,
			    password_confirmation: password
				}
			end

			it "should add a new user to the database" do
				expect(User.count).to eq(@users_count + 1)
			end

			it "should redirect to user_path" do
				expect(response.status).to be(302)
				expect(response.location).to match(/\/users\/\d+/)
			end
		end

		context "failed validations" do
			before do
				post :create, user: {
					name: nil,
			    email: nil,
			    password: nil,
			    password_confirmation: nil
				}
			end

			it "should display an error message" do
				expect(flash[:error]).to be_present
			end

			it "should redirect to new_user_path" do
				expect(response.status).to be(302)
				expect(response).to redirect_to(signup_path)
			end
		end
	end

	describe "#show" do
		before do
			@user = FactoryGirl.create(:user)
			get :show, id: @user.id
		end

		it "should assign @user" do
			expect(assigns(:user)).to eq(@user)
		end

		it "should render the :show view" do
			expect(response).to render_template(:show)
		end
	end


end
