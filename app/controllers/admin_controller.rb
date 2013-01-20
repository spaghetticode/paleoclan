class AdminController < AuthenticatedController
  before_filter :check_admin

  private

  def check_admin
    unless current_user.admin?
      redirect_to root_path, :alert => 'Non puoi entrare in amministrazione.'
    end
  end
end
