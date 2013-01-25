class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :today, :reservations_time?, :roulette?, :weekend?

  private

  delegate :reservations_time?, :roulette?, :hour, :weekend?, :to => :today

  def today
    @today ||= Day.today
  end
end
