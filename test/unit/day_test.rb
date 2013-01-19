require 'test_helper'

class DayTest < ActiveSupport::TestCase
  def setup
    @day = FactoryGirl.create(:day)
  end

  def day_with(str)
    FactoryGirl.create :day, :date => Date.parse(str)
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

  test 'day next_day is the day after' do
    expected = @day.date + 1
    assert_equal expected, @day.next_day.date
  end

  test 'sunday has monday as next_available' do
    sunday = day_with('2013/1/6')
    monday = day_with('2013/1/7')
    assert_equal monday, sunday.next_available
  end

  test 'saturday has monday as next_available' do
    saturday = day_with('2013/1/5')
    monday   = day_with('2013/1/7')
    assert_equal monday, saturday.next_available
  end

  test 'friday has monday as next_available' do
    friday = day_with('2013/1/4')
    monday = day_with('2013/1/7')
    assert_equal monday, friday.next_available
  end
end
