class TodaysController < ApplicationController
  before_filter :authenticate_user!

  def show
    redirect_to roulette_path if friday?
  end
end
