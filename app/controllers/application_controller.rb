class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper_method :today, :reservations_time?

  private

  def reservations_time?
    hour = Time.zone.now.hour
    !!(hour >= 10 and hour <= 12)
  end

  def today
    @today ||= Day.today
  end
end
