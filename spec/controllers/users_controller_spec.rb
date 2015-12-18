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

	describe "#edit" do
		before do
			@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id
			get :edit, id: @user.id
		end

		it "should assign @product" do
			expect(assigns(:product)).to eq(@product)
		end

		it "should render the :edit view" do
			expect(response).to render_template(:edit)
		end
	end

	describe "#update" do
		before do
			@user = FactoryGirl.create(:user)
			session[:user_id] = @user.id
		end

		context "success" do
			before do
				@new_password = FFaker::Internet.password
				@new_name = FFaker::Name.first_name
				@new_email = FFaker::Internet.email

				post :update, id: @user.id, user: {
					name: @new_name,
			    email: @new_email,
			    password: @new_password,
			    password_confirmation: @new_password
				}
				# reload @user to get changes from :update
				@user.reload
			end

			it "should update user in the database" do
				expect(@user.name).to eq(@new_name)
				expect(@user.email).to eq(@new_email)
			end

			it "should redirect to user" do
				expect(response.status).to be(302)
				expect(response).to redirect_to(user_path(@user))
			end
		end
	end

	describe "#destroy" do
		before do
			user = FactoryGirl.create(:user)
			session[:user_id] = user.id
			@users_count = User.count
			delete :destroy, id: user.id
		end

		it "should remove user from the database" do
			expect(User.count).to eq(@users_count - 1)
		end

		it "should redirect to root_path" do
			expect(response.status).to be(302)
			expect(response).to redirect_to(login_path)
		end
	end
end
