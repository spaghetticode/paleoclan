class PagesController < ApplicationController

  def index
    redirect_to today_path if current_user
  end
end
