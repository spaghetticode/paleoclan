class Admin::SlotsController < AdminController
  def index
    @slots = today.slots
  end

  def destroy
    @slot = Slot.find params[:id]
    @slot.destroy
    redirect_to admin_slots_path, :notice => 'Slot eliminato.'
  end
end
