require 'test_helper'

# TODO this test code (and most of the controller code too)
# applies to both bet and slot. Should go DRY.

class BetsControllerTest < ActionController::TestCase
  test 'redirects to homepage when not logged in' do
    post :create
    assert_redirected_to root_path
  end

  test 'redirects to today_path when not roulette day' do
    @controller.stubs(:roulette?).returns(false)
    sign_in :user, FactoryGirl.create(:user)
    post :create
    assert_redirected_to today_path
  end

  test 'sets notice message when successfully creates bet' do
    Bet.any_instance.stubs(:save).returns(true)
    @controller.stubs(:roulette?).returns(true)
    sign_in :user, FactoryGirl.create(:user)
    post :create
    assert flash[:notice].present?
  end

  test 'sets alert message when cant create bet' do
    Bet.any_instance.stubs(:save).returns(false)
    @controller.stubs(:roulette?).returns(true)
    sign_in :user, FactoryGirl.create(:user)
    post :create
    assert flash[:alert].present?
  end
end
