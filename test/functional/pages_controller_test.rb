require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test '#index renders if not logged in' do
    get :index
    assert_response :success
  end

  test '#index redirects to today page if logged in' do
    sign_in_user
    get :index
    assert_redirected_to today_path
  end

  test '#rules redirects when not logged in' do
    get :rules
    assert_response :redirect
  end

  test '#rules renders when logged in' do
    sign_in_user
    get :rules
    assert_response :success
  end

  test '#menu redirects when not logged in' do
    get :menu
    assert_response :redirect
  end

  test '#menu renders when logged in' do
    sign_in_user
    get :menu
    assert_response :success
  end
end
