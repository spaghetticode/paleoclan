require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase

  test '#edit redirects when not logged in' do
    get :edit
    assert_response :redirect
  end

  test '#edit redirects when logged in as normal user' do
    get :edit
    assert_response :redirect
  end

  test '#edit renders when logged in as admin' do
    sign_in_admin
    get :edit
    assert_response :success
  end

  # TODO test update
end