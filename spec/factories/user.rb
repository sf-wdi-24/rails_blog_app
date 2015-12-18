FactoryGirl.define do
  factory :user do
    before do
      email = FFaker::Internet.email
      password = FFaker::Lorem.words(5).join
      @user = User.create(user_params)
    end
  end

end
