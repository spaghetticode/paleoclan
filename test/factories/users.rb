# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "andrea#{n}@paleoclan.org"}
    password 'secret'
  end

  factory :admin, :parent => :user do
    admin true
  end
end
