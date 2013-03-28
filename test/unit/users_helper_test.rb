# encoding: utf-8
require 'test_helper'

class UsersHelperTest < ActionView::TestCase

  include UsersHelper

  test "full_message_for_not_registered_user" do
    current_user = User.new(:name => "Mario")
    today_user_names = %w(Paolo Pietro Giovanni)
    message = full_clan_message_for current_user, today_user_names
    assert_equal "Spiacente, il clan oggi è già al completo.", message
  end

  test "test_full_message_for_registered_user" do 
    current_user = User.new(:name => "Mario")
    today_user_names = %w(Mario Pietro Giovanni)
    message = full_clan_message_for current_user, today_user_names
    assert_equal "Sei prenotato per oggi! Buon appetito!", message
  end

end
