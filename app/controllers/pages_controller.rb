class PagesController < AuthenticatedController
  skip_before_filter :authenticate_user!, :only => :index

  def index
    redirect_to today_path if current_user
  end

  def rules
  end

  def menu
  end
end
