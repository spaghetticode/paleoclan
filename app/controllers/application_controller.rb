class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :today, :reservations_time?, :roulette?, :weekend?

  private

  def reservations_time?
    hour >= Settings.open_hour and hour <= Settings.close_hour
  end

  def today
    @today ||= Day.today
  end

  def roulette?
    Date.today.wday == Settings.roulette
  end

  def hour
    @hour ||= Time.zone.now.hour
  end

  def weekend?
    today.weekend?
  end
end
