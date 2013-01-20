# encoding: utf-8

class Admin::SettingsController < AdminController
  def edit
    @settings = Settings.instance
  end

  def update
    @settings = Settings.instance
    if @settings.update_attributes params[:settings]
      redirect_to edit_admin_settings_path, :notice => 'Configurazione aggiornata.'
    else
      flash[:alert] = 'Non è possibile aggiornare la configurazione.'
      render :action => 'edit'
    end
  end
end
