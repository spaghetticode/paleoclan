class Day < ActiveRecord::Base
  has_many :bets
  has_many :slots
  has_many :users, :through => :slots

  attr_accessible :capability, :date

  validates_uniqueness_of :date

  before_create :set_capability

  def self.today
    find_or_create_by_date(Date.today)
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

  def extract_winners
    users = bets.map(&:user)
    availability.times do
      user = users.delete(users.sample)
      Slot.create(:user => user, :day => self)
    end
  end

  def weekend?
    [0, 6].include? date.wday
  end

  def settings_capability
    Settings.capability
  end

  def availability
    capability - slots.size - Settings.default.size
  end

  def next_day
    self.class.find_or_create_by_date(date + 1)
  end

  def next_available
    if next_day.weekend?
      next_day.next_available
    else
      next_day
    end
  end

  private

  def set_capability
    self.capability = settings_capability unless capability
  end
end
