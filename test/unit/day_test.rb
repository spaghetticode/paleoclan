require 'test_helper'

class DayTest < ActiveSupport::TestCase
  def setup
    @day = FactoryGirl.create(:workday)
  end

  def day_on(str)
    FactoryGirl.create :day, :date => Date.parse(str)
  end

  test 'is valid' do
    assert @day.valid?
  end

  test 'has default capability' do
    assert_equal 3, @day.capability
  end

  test 'is not full when there is availability' do
    @day.stubs(:availability).returns(1)
    assert !@day.full?
  end

  test 'is full when there is no availability ' do
    @day.stubs(:availability).returns(0)
    assert @day.full?
  end

  test 'Day.today creates a new day' do
    assert Day.today
  end

  test 'has expected availability' do
    assert_equal 2, @day.availability
  end

  test 'Date.today date is today' do
    assert_equal Date.today, Day.today.date
  end

  test 'day next_day is the day after' do
    expected = @day.date + 1
    assert_equal expected, @day.next_day.date
  end

  test 'days on sundays are weekend' do
    day = day_on('2013/1/6')
    assert day.weekend?
  end

  test 'days on saturdays are weekend' do
    day = day_on('2013/1/5')
    assert day.weekend?
  end

  test 'sunday has monday as next_available' do
    sunday = day_on('2013/1/6')
    monday = day_on('2013/1/7')
    assert_equal monday, sunday.next_available
  end

  test 'saturday has monday as next_available' do
    saturday = day_on('2013/1/5')
    monday   = day_on('2013/1/7')
    assert_equal monday, saturday.next_available
  end

  test 'friday has monday as next_available' do
    friday = day_on('2013/1/4')
    monday = day_on('2013/1/7')
    assert_equal monday, friday.next_available
  end

  test 'extract_winners creates 2 slots when enough users bid on the day' do
    users = (0..1).map {FactoryGirl.create :user}
    @day.stubs(:bets_users).returns(users)
    assert_difference 'Slot.count', 2 do
      @day.extract_winners
    end
  end

  test 'extract_winners creates 1 slot when there is only 1 user that can book' do
    users = (0..1).map {FactoryGirl.create :user}
    users.last.stubs(:cant_book?).returns(true)
    @day.stubs(:bets_users).returns(users)
    assert_difference 'Slot.count', 1 do
      @day.extract_winners
    end
  end

  test '#reservations_time? is true when hour is lower than settings close_hour'do
    @day.stubs(:hour).returns(11)
    assert @day.reservations_time?
  end

  test '#reservations_time? is false when hour is equal to settings close_hour'do
    @day.stubs(:hour).returns(12)
    assert !@day.reservations_time?
  end

   test '#reservations_time? is false when hour is lower than settings open_hour'do
    @day.stubs(:hour).returns(9)
    assert !@day.reservations_time?
  end

  test '#roulette is true on roulette day' do
    @day.stubs(:wday).returns(5)
    assert @day.roulette?
  end

  test '#roulette is false on other days' do
    @day.stubs(:wday).returns(2)
    assert !@day.roulette?
  end
end
