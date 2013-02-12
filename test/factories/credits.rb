# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit do
    association :user
  end
end
