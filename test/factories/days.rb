# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day do
    sequence(:date) {|n| Date.today + n}
  end
end
