require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  def setup
    @rating = Rating.new
  end

  test 'requires a user' do
    @rating.valid?
    assert @rating.errors[:user_id].present?
  end

  test 'requires a day' do
    @rating.valid?
    assert @rating.errors[:day_id].present?
  end

  test 'requires a value' do
    @rating.valid?
    assert @rating.errors[:value].present?
  end

  test 'is valid' do
    rating = FactoryGirl.build(:rating)
    assert rating.valid?
  end

  test 'is unique for day/user combination' do
    valid = FactoryGirl.create(:rating )
    @rating.day  = valid.day
    @rating.user = valid.user
    @rating.valid?
    assert @rating.errors[:user_id].present?
  end
end
