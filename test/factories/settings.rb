# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting, :class => 'Settings' do
    data "MyString"
  end
end
