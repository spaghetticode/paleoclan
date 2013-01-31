module ApplicationHelper
  def button_to_change_ban_status(user)
    text = user.banned? ? 'unban' : 'ban'
    method = "admin_user_#{text}_path"
    button_to text, send(method, user), :method => :put, :class => text
  end

  def admin_area
    yield if current_user.present? and current_user.admin?
  end

  def body_class
    [controller.controller_name, controller.action_name].join('_')
  end

  def rating_link
    url = rating_allowed? ? new_rating_path : ratings_path
    link_to 'feedback', url
  end
end
