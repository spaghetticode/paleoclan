require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  test '#index redirects when not logged in' do
    get :index
    assert_response :redirect
  end

  test '#index redirects when logged in as regular user' do
    sign_in_user
    get :index
    assert_response :redirect
  end

  test '#index renders when logged in as admin user' do
    sign_in_admin
    get :index
    assert_response :success
  end
end
