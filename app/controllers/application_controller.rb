class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :today, :reservations_time?, :friday?

  private

  def reservations_time?
    hour = Time.zone.now.hour
    hour >= 10 and hour <= 12
  end

  def today
    @today ||= Day.today
  end

  def friday?
    Date.today.wday == 6
  end
end
