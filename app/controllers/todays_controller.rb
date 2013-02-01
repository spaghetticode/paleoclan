class TodaysController < AuthenticatedController
  before_filter :redirect_to_new_rating_if_user_can_rate
  def show
    redirect_to roulette_today_path if roulette?
  end

  def roulette
    redirect_to today_path unless roulette?
    extract_winners
  end

  private

  def extract_winners
    today.extract_winners if !today.full? and hour >= Settings.close_hour
  end

  def redirect_to_new_rating_if_user_can_rate
    if rating_allowed? and hour > Settings.close_hour
      redirect_to new_rating_path
    end
  end
end
