class Slot < ActiveRecord::Base
  belongs_to :day
  belongs_to :user

  attr_accessible :day_id, :user_id, :day, :user

  validates_presence_of   :day_id, :user_id, :allow_blank => false
  validates_uniqueness_of :day_id, :scope => :user_id
end
