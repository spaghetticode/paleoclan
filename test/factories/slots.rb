# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    user
    association :day, :factory => :workday
  end
end
