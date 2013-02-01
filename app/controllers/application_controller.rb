class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :today, :reservations_time?, :roulette?, :weekend?, :rating_allowed?

  private

  delegate :reservations_time?, :roulette?, :hour, :weekend?, :to => :today

  def today
    @today ||= Day.today
  end

  def rating_allowed?
    return false unless current_user
    hour > Settings.close_hour and current_user.can_rate?(today)
  end
end
