# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    user
    association :day, :factory => :workday
  end
end
