require 'rails_helper'

RSpec.describe User, type: :model do
  before do
		user_params = Hash.new
		user_params[:name] = FFaker::Name.first_name
		user_params[:email] = FFaker::Internet.email
		user_params[:password] = FFaker::Lorem.words(2).join
		user_params[:password_confirmation] = user_params[:password]
		@user = User.new(user_params)
	end

  describe "user validation" do
    it "user validations should work" do
      expect(@user.save).to eq(true)
    end
  end

  describe "#user email attributes" do
    it "email should NOT be valid format" do
      @invalid_user = User.new(email: "stanleyyorkgmailcom")
      expect(@invalid_user.save).to eq(false)
    end
    it "email should match email " do
      expect(@user.email).to eq("#{@user.email}")
    end
  end

  describe "#user name attributes" do
    it "name should match name " do
      expect(@user.name).to eq("#{@user.name}")
    end
  end

end