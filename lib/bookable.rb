module Bookable
  extend ActiveSupport::Concern

  included do
    belongs_to :day
    belongs_to :user

    attr_accessible :day_id, :user_id, :day, :user

    validates_presence_of   :day_id, :user_id
    validates_uniqueness_of :day_id, :scope => :user_id

    validate :validate_day
    validate :validate_user

    default_scope order('created_at DESC')

    def user_name
      user.name
    end

    private

    def validate_day
      return unless day
      errors.add :day_id, "#{day.date} is weekend!" if day.weekend?
    end

    def validate_user
      return unless user
      errors.add :user_id, 'cannot book this user' if user.cant_book?(day)
    end
  end
end