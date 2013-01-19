class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => :rules

  def index
    redirect_to today_path if current_user
  end

  def rules
  end
end
