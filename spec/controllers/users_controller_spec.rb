require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	before do
		user_params = Hash.new
		user_params[:name] = FFaker::Name.first_name
		user_params[:email] = FFaker::Internet.email
		user_params[:password] = FFaker::Lorem.words(2).join
		user_params[:password_confirmation] = user_params[:password]
		@user = User.create(user_params)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
	end
end