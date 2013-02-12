class Admin::CreditsController < AdminController
  def create
    if user.add_credit
      redirect_to :back, :notice => 'Credito aggiunto'
    else
      redirect_to :back, :alert => 'Impossibile aggiungere il credito'
    end
  end

  def use
    if user.use_credit
      redirect_to :back, :notice => 'Credito usato'
    else
      redirect_to :back, :alert => 'Impossibile usare il credito'
    end
  end

  def destroy
    user.destroy_credit
    redirect_to :back
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end
end
