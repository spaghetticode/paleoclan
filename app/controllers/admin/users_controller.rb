class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def ban
    @user = User.find params[:user_id]
    @user.ban
    redirect_to admin_users_path, :notice => 'Utente bannato.'
  end

  def unban
    @user = User.find params[:user_id]
    if @user.unban
      flash[:notice] = 'Utente sbannato.'
    else
      flash[:alert] = "L'utente ha raggiunto il limite di ban."
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admin_users_path, :notice => 'Utente cancellato.'
  end
end
