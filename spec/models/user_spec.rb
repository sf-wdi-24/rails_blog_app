require 'rails_helper'
require 'ffaker'

RSpec.describe User, type: :model do

  before do
    user_params = Hash.new
    user_params[:email] = FFaker::Internet.email
    user_params[:password] = FFaker::Lorem.word
    @user = User.create(user_params)
   end

    describe "#email" do
  		it "has an email address" do
  			expect(@user.email).to eq("#{@user.email}")
  	end
  end
    describe "#password" do
  		it "has a password" do
  			expect(@user.password).to eq("#{@user.password}")
  	end
  end


end
