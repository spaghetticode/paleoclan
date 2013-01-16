# coding: utf-8

class SlotsController < ApplicationController
  def create
    if reservations_time?
      @slot = Slot.new(:user => current_user, :day => today)
      if @slot.save
        redirect_to today_path, :notice => 'Ti sei prenotato per il pranzo di oggi' and return
      end
    end
    redirect_to today_path, :alert => 'Mi spiace non è possibile accettare la tua prenotazione'
  end

  def destroy
    @slot = today.slots.where(:user_id => current_user.id)
    @slot.destroy if @slot
    redirect_to today_path, :notice => 'La tua prenotazione per oggi è stata cancellata'
  end
end
