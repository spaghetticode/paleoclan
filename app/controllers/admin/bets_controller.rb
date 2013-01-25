class Admin::BetsController < AdminController
  def index
    @bets = today.bets
  end

  def destroy
    @bet = Bet.find params[:id]
    @bet.destroy
    redirect_to admin_bets_path, :notice => 'Iscrizione alla roulette eliminata.'
  end
end
