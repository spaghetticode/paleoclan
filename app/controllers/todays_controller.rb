class TodaysController < ApplicationController
  before_filter :authenticate_user!

  def show
    redirect_to roulette_today_path if friday?
  end

  def roulette
    redirect_to today_path unless friday?
  end
end
