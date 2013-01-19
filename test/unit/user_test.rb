require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = FactoryGirl.create(:user)
  end

  test 'is valid' do
    assert @user.valid?
  end

  test 'is not banned' do
    assert !@user.banned?
  end

  test 'cant book when banned' do
    @user.stubs(:banned?).returns(true)
    today  = FactoryGirl.create :day, :date => Date.parse('2013/1/3')
    assert @user.cant_book?(today)
  end

  test 'can book when user has booked for only 1 day' do
    today  = FactoryGirl.create :day, :date => Date.parse('2013/1/2')
    first  = FactoryGirl.create :day, :date => Date.parse('2013/1/1')
    FactoryGirl.create :slot, :user => @user, :day => first
    assert @user.can_book?(today)
  end

  test 'can book when user has booked for 2 not consecutive days' do
    today  = FactoryGirl.create :day, :date => Date.parse('2013/1/7')
    first  = FactoryGirl.create :day, :date => Date.parse('2013/1/2')
    second = FactoryGirl.create :day, :date => Date.parse('2013/1/4')
    [first, second].each do |day|
      FactoryGirl.create :slot, :user => @user, :day => day
    end
    assert @user.can_book?(today)
  end

  test 'cant book when user has booked for the previous 2 workdays' do
    today  = FactoryGirl.create :day, :date => Date.parse('2013/1/7')
    first  = FactoryGirl.create :day, :date => Date.parse('2013/1/3')
    second = FactoryGirl.create :day, :date => Date.parse('2013/1/4')
    [first, second].each do |day|
      FactoryGirl.create :slot, :user => @user, :day => day
    end
    assert @user.cant_book?(today)
  end

  test 'is banned when ban_count is not zero and banned attribute is true' do
    @user.banned = true
    @user.ban_count = 1
    assert @user.banned?
  end

  test '#ban increases ban_count' do
    assert_difference '@user.ban_count', 1 do
      @user.ban
    end
  end

  test '#unban removes banned attribute' do
    @user.ban
    @user.unban
    assert !@user.banned
  end

  test '#unban doesnt change ban_count' do
    @user.ban
    @user.unban
    assert_equal 1, @user.ban_count
  end

  test '#bet? is true when user has already bet on the given day' do
    bet = FactoryGirl.create :bet, :user => @user
    assert @user.bet?(bet.day)
  end
end
