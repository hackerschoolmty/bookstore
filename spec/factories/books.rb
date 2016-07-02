FactoryGirl.define do
  factory :book do
    name { Faker::Book.title }
    author { Faker::Book.author }
    sequence(:slug) {|n| "12345-#{n}"}

    factory :rails_book do
      name "Rails book"
    end

    factory :ruby_book do
      name "Ruby book"
    end

    factory :spec_book do
      name "Spec book"
    end

    factory :book_with_comments do
      after(:create) do |book|
        create_list(:comment, rand(2..5), book: book)
      end
    end

    factory :book_with_pictures do
      after(:create) do |book|
        create_list(:picture, rand(2..5), picturable: book)
      end
    end
  end
end