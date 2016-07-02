FactoryGirl.define do
  factory :user do
    name { Faker::Name.name  }
    sequence(:email) { |n| "user-#{n}@hackerschool.com"}
    password "password"
    password_confirmation "password"
    role "admin"
  end
end