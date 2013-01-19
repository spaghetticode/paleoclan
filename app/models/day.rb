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
    availability < 1
  end

  def user_names
    users.map(&:name)
  end

  def users_count
    users.count
  end

  def extract_winners
    users = bets_users
    while availability > 0 and users.present?
      user = users.delete(users.sample)
      slot = Slot.create(:user => user, :day => self)
    end
  end

  def weekend?
    [0, 6].include? date.wday
  end

  def availability
    capability - slots.count - Settings.default.size
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

  def settings_capability
    Settings.capability
  end

  def bets_users
    bets.map(&:user)
  end
end
