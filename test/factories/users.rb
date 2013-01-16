# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "andrea#{n}@paleoclan.org"}
    password 'secret'
  end
end
