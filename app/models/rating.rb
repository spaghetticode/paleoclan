class Rating < ActiveRecord::Base
  belongs_to :day
  belongs_to :user

  attr_accessible :day_id, :day, :user_id, :user, :value

  validates_presence_of :day_id, :user_id, :value
  validates_inclusion_of :value, :in => 1..5
  validates_uniqueness_of :user_id, :scope => :day_id


end
