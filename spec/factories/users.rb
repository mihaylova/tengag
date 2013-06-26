# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end

    sequence :username do |n|
      "user#{n}"
    end

    password 12345678
    password_confirmation 12345678
  end
end
