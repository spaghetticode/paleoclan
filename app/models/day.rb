class Day < ActiveRecord::Base
  has_many :slots
  has_many :users, :through => :slots

  attr_accessible :capability, :date

  validates_uniqueness_of :date

  before_create :set_capability

  def self.today
    Day.find_or_create_by_date(Date.today)
  end

  def full?
    slots.count >= settings_capability
  end

  def user_names
    users.map(&:name)
  end

  def users_count
    users.count
  end

  private

  def set_capability
    self.capability = settings_capability unless capability
  end

  def settings_capability
    Settings.capability
  end
end
