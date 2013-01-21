# coding: utf-8
# slots are for regular days, while bets are for roulette days

class SlotsController < AuthenticatedController
  def create
    redirect_to today_roulette_path if roulette?
    if reservations_time?
      @slot = Slot.new(:user => current_user, :day => today)
      if @slot.save
        redirect_to today_path, :notice => 'Ti sei prenotato per il pranzo di oggi' and return
      end
    end
    redirect_to today_path, :alert => 'Mi spiace non è possibile accettare la tua prenotazione'
  end
end
