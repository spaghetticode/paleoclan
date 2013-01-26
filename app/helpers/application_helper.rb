module ApplicationHelper
  def button_to_change_ban_status(user)
    text = user.banned? ? 'unban' : 'ban'
    method = "admin_user_#{text}_path"
    button_to text, send(method, user), :method => :put, :class => text
  end

  def admin_area
    yield if current_user.present? and current_user.admin?
  end
end
