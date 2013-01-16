require 'test_helper'

class DayTest < ActiveSupport::TestCase
  def setup
    @day = FactoryGirl.create(:day)
  end

  test 'is valid' do
    assert @day.valid?
  end

  test 'has default capability' do
    assert_equal 1, @day.capability
  end

  test 'is not full' do
    assert !@day.full?
  end

  test 'is full' do
    FactoryGirl.create(:slot, :day_id => @day.id)
    assert @day.full?
  end

  test 'Day.today creates a new day' do
    assert Day.today
  end

  test 'Date.today date is today' do
    assert_equal Date.today, Day.today.date
  end
end
