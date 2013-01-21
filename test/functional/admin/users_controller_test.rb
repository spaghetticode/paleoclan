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

  test '#ban redirects' do
    user = FactoryGirl.build :user
    user.stubs(:ban).returns(true)
    User.stubs(:find).returns(user)
    sign_in_admin
    put :ban, :user_id => 42
    assert_redirected_to admin_users_path
  end

  # test '#ban bans the user' do
  #   user = FactoryGirl.build :user
  #   user.expects(:ban).returns(true)
  #   User.stubs(:find).returns(user)
  #   sign_in_admin
  #   put :ban, :user_id => 42
  # end

  test '#unban redirects' do
    user = FactoryGirl.build :user
    user.stubs(:unban).returns(true)
    User.stubs(:find).returns(user)
    sign_in_admin
    put :unban, :user_id => 42
    assert_redirected_to admin_users_path
  end

  test '#unban when successful has a notice message' do
    user = FactoryGirl.build :user
    User.stubs(:find).returns(user)
    user.stubs(:unban).returns(true)
    sign_in_admin
    put :unban, :user_id => 42
    assert flash[:notice].present?
  end

  test '#unban when failing has a alert message' do
    user = FactoryGirl.build :user
    User.stubs(:find).returns(user)
    user.stubs(:unban).returns(false)
    sign_in_admin
    put :unban, :user_id => 42
    assert flash[:alert].present?
  end

  test '#destroy redirects' do
    user = FactoryGirl.build :user
    user.stubs(:destroy).returns(true)
    User.stubs(:find).returns(user)
    sign_in_admin
    delete :destroy, :user_id => 42
    assert_redirected_to admin_users_path
  end
end
