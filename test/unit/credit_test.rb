require 'test_helper'

class CreditTest < ActiveSupport::TestCase
  test 'is not used' do
    assert !Credit.new.used
  end

  test 'requires a user' do
    credit = Credit.new
    credit.valid?
    assert credit.errors[:user_id].present?
  end

  test '::used finds used credits' do
    used = FactoryGirl.create :credit, :used => true
    unused = FactoryGirl.create :credit
    assert_equal [used], Credit.used
  end

  test '::unused finds unused credits' do
    used = FactoryGirl.create :credit, :used => true
    unused = FactoryGirl.create :credit
    assert_equal [unused], Credit.unused
  end

  test '#use changes used to true' do
    unused = FactoryGirl.create :credit
    unused.use
    assert unused.used
  end
end
