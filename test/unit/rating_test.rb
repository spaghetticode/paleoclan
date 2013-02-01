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

  test ':for_user builds a new rating' do
    user = FactoryGirl.create :user
    assert Rating.for_user(user).new_record?
  end

  test ':for_user finds the existing rating' do
    rating = FactoryGirl.create :rating
    assert_equal rating, Rating.for_user(rating.user)
  end

  test ':grouped groups by day' do
    groups = (0..2).inject [] do |array, n|
      day = FactoryGirl.create :day, :date => Date.today + n
      rating = FactoryGirl.create :rating, :day => day
      array << [day, rating]
    end
    grouped = Rating.grouped
    groups.each do |couple|
      day, rating = couple
      assert_equal grouped[day], [rating]
    end
  end
end
