FactoryGirl.define do
  factory :user do
    email FFaker::Internet.email
    password FFaker::Lorem.words(2).join
  end
end