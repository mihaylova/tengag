# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    link "MyString"
    picture_file_name 'Picture file name'
    hot false
    association :user
  end
end
