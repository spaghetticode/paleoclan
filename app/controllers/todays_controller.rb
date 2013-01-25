class TodaysController < AuthenticatedController
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
end
