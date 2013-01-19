# Read about factories at https://github.com/thoughtbot/factory_girl

def next_workday(date)
  next_day = date + 1
  if [6, 0].include? next_day.wday
    next_workday(next_day)
  else
    next_day
  end
end

FactoryGirl.define do
  factory :day do
    sequence(:date) do |n|
      next_workday(Date.today + n)
    end
  end

  factory :workday, :class => Day do
    sequence(:date) do |n|
      next_workday(Date.today + n)
    end
  end
end
