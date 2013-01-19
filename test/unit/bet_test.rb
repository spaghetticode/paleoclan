# TODO same stuff as slot_test.rb, should DRY it...

require 'test_helper'

class BetTest < ActiveSupport::TestCase
  def setup
    @slot = FactoryGirl.create(:bet)
  end

  test 'is valid' do
    assert @slot.valid?
  end

  test 'requires user' do
    slot = Bet.new
    slot.valid?
    assert slot.errors[:user_id].present?
  end

  test 'requires day' do
    slot = Bet.new
    slot.valid?
    assert slot.errors[:day_id].present?
  end

  test 'requires unique day/user combination' do
    invalid = Bet.new(:user_id => @slot.user_id, :day_id => @slot.day_id)
    assert !invalid.valid?
  end

  test 'requires a user that can book' do
    @slot.user.stubs(:cant_book?).returns(true)
    assert !@slot.valid?
  end

  test 'requires a day that is not weekend' do
    @slot.day.stubs(:weekend?).returns(true)
    assert !@slot.valid?
  end
end
