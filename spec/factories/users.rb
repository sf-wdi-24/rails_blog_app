FactoryGirl.define do
  factory :user do
    name { FFaker::Internet.name }
		email { FFaker::Internet.email }
		password { FFaker::Internet.password }
  end

end
