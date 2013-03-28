# encoding: utf-8
module UsersHelper

  def full_clan_message_for user, booked_user_names
    if booked_user_names.include? user.name
      return "Sei prenotato per oggi! Buon appetito!"
    else
      return "Spiacente, il clan oggi è già al completo."
    end
  end
end
