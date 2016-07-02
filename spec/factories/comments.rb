FactoryGirl.define do
  factory :comment do
    description { Faker::Lorem.sentence }
    user
    book
  end
end