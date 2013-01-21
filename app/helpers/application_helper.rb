module ApplicationHelper
  def button_to_change_ban_status(user)
    if user.banned?
      button_to 'unban'
    else
      button_to 'ban'
    end
  end
end
