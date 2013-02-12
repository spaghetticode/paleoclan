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

  test 'has credits association' do
    assert @user.credits
  end


  # booking related methods

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


  # ban related methods

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

  test '#unban has no effect if user has been banned 3 times' do
    3.times {@user.ban}
    @user.unban
    assert @user.banned
  end

  test '#unban doesnt change ban_count' do
    @user.ban
    @user.unban
    assert_equal 1, @user.ban_count
  end


  # rating related methods

  test '#bet? is true when user has already bet on the given day' do
    bet = FactoryGirl.create :bet, :user => @user
    assert @user.bet?(bet.day)
  end

  test '#can_rate? is true when user has a slot on the given day' do
    slot = FactoryGirl.create :slot, :user => @user
    assert @user.can_rate?(slot.day)
  end

  test '#can_rate? is false when user has no slot on the given day' do
    assert !@user.can_rate?(Day.today)
  end

  test '#can_rate? is true when user name is included in settings defaults' do
    @user.stubs(:name).returns(Settings.default.first)
    assert @user.can_rate?(Day.today)
  end


  # credit related methods

  test '#add_credit adds a credit to the user' do
    assert_difference '@user.credits.count', +1 do
      @user.add_credit
    end
  end

  test '#use_credit use a credit if available' do
    credit = FactoryGirl.create :credit, :user => @user
    @user.use_credit
    assert credit.reload.used
  end

  test '#use_credit is truthy when successful' do
    credit = FactoryGirl.create :credit, :user => @user
    assert @user.use_credit
  end

  test '#use_credit is falsy when fails' do
    assert !@user.use_credit
  end

  test '#destroy_credit destroys a user credit' do
    credit = FactoryGirl.create :credit, :user => @user
    @user.destroy_credit
    assert @user.credits.reload.empty?
  end

  test '#destroy_credit is truthy when successful' do
    credit = FactoryGirl.create :credit, :user => @user
    assert @user.destroy_credit
  end

  test '#destroy_credit is falsy when fails' do
    assert !@user.destroy_credit
  end
end
