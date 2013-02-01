require 'test_helper'

class Admin::BetsControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in_admin
    get :index
    assert_response :success
  end

  test "should get destroy" do
    bet = stub(:destroy => true)
    Bet.stubs(:find).returns(bet)
    sign_in_admin
    get :destroy, :id => 1
    assert_response :redirect
  end
end
