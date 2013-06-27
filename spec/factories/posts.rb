# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    link "MyString"
    picture "MyString"
    hot false
    user ""
  end
end
