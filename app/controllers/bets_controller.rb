# coding: utf-8
# slots are for regular days, while bets are for roulette days

class BetsController < AuthenticatedController
  def create
    unless roulette?
      redirect_to today_path and return
    end
    @bet = Bet.new(:user => current_user, :day => today)
    if @bet.save
      redirect_to roulette_today_path, :notice => 'Grazie per esserti iscritto alla roulette!'
    else
      redirect_to roulette_today_path, :alert => 'Mi spiace non è possibile accettare la tua richiesta.'
    end
  end
end
