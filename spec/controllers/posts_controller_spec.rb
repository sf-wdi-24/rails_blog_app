require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	describe "#index" do
		before do
			@all_posts = Post.all
			get :index
		end

		it "should assign @posts" do
			expect(assigns(:posts)).to eq(@all_posts)
		end

		it "should render the :index view" do
			expect(response).to render_template(:index)
		end
	end

	describe "#new" do
		context "logged in" do
      before do
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
        @current_user = FactoryGirl.create(:user)
        session[:user_id] = @current_user.id
      end

			context "success" do
				before do
					@posts_count = Post.count

					post :create, post: {
						title: FFaker::Lorem.words(),
						content: FFaker::Lorem.words(20)
					}
				end

				it "should add new post to database" do
					expect(response.status).to be(302)
					expect(response.location).to match(/\/posts\/\d+/)
				end
			end

			context "failed vaidations" do
				before do
					post :create, post: {
						title: FFaker::Lorem.words(2),
						content: FFaker::Lorem.words(20)
					}
				end

				it "should display and error message" do
					expect(flash[:error].to be_present)
				end

				it "should redirect to 'new_post_path'" do
					expect(response.status).to be(302)
					expect(response).to redirect_to(new_post_path)
				end
			end
		end
		context "not logged in" do
		  before do
		    post :create, post: { title: FFaker::Lorem.words(4).join(" "), content: FFaker::Lorem.paragraph }
		  end
		  it "should redirect to 'login_path'" do
		  	expect(response.status).to be(302)
		  	expect(response).to redirect_to(login_path)
		  end
		end
	end

	describe "#show" do

	end
	describe "#edit" do
	end
	describe "#update" do
	end
	describe "#destroy" do
	end
end
