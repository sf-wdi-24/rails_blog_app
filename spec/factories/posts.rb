FactoryGirl.define do
  factory :post do
    title { FFaker::Lorem.words(2) }
    content { FFaker::Lorem.words(20) }
  end

end
