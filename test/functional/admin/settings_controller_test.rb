require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase

  test 'redirects when not logged in' do
    get :edit
    assert_response :redirect
  end

  test 'redirects when logged in as normal user' do
    get :edit
    assert_response :redirect
  end

  test 'renders when logged in as admin' do
    sign_in :user, FactoryGirl.create(:admin)
    get :edit
    assert_response :success
  end

  # TODO test update
end