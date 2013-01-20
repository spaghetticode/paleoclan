require 'test_helper'

class TodaysControllerTest < ActionController::TestCase
  def setup
    sign_in :user, FactoryGirl.create(:user)
  end

  test '#show redirects on roulette days' do
    @controller.stubs(:roulette?).returns(true)
    get :show
    assert_response :redirect
  end

  test '#show renders on regular days' do
    @controller.stubs(:roulette?).returns(false)
    get :show
    assert_response :success
  end

  test '#roulette redirects on regular days' do
    @controller.stubs(:roulette?).returns(false)
    get :roulette
    assert_response :redirect
  end

  test '#roulette renders on roulette days' do
    @controller.stubs(:roulette?).returns(true)
    @controller.stubs(:extract_winners)
    get :roulette
    assert_response :success
  end
end
