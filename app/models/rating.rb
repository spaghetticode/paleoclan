class Rating < ActiveRecord::Base
  belongs_to :day
  belongs_to :user

  attr_accessible :day_id, :day, :user_id, :user, :value

  validates_presence_of :day_id, :user_id, :value
  validates_inclusion_of :value, :in => 1..5
  validates_uniqueness_of :user_id, :scope => :day_id

  def self.for_user(user)
    where(:user_id => user.id).first or new
  end

  def self.grouped
    all.inject Hash.new do |hash, rating|
      hash[rating.day] ||= []
      hash[rating.day] << rating
      hash
    end
  end

  def user_name
    user.try(:name)
  end

  def on
    value
  end

  def off
    5 - on
  end
end
