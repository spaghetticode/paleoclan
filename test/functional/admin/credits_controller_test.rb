require 'test_helper'

class Admin::CreditsControllerTest < ActionController::TestCase
  def setup
    request.env['HTTP_REFERER'] = '/somewhere'
  end

  test '#create redirects when not signed in' do
    post :create, :user_id => 42
    assert_redirected_to root_path
  end

  test '#create redirects when signed in as user' do
    sign_in_user
    post :create, :user_id => 42
    assert_redirected_to root_path
  end

  test '#create flashes with notice when logged in as admin' do
    sign_in_admin
    stub_user(:add_credit => true)
    post :create, :user_id => 42
    assert flash[:notice]
  end

  test '#create flashes with alert when cannot create a credit' do
    sign_in_admin
    stub_user(:add_credit => false)
    post :create, :user_id => 42
    assert flash[:alert]
  end

  test '#create redirects back' do
    sign_in_admin
    stub_user(:add_credit => false)
    post :create, :user_id => 42
    assert_redirected_to '/somewhere'
  end

  test '#destroy redirects back' do
    sign_in_admin
    stub_user(:destroy_credit => true)
    delete :destroy, :user_id => 42
    assert_redirected_to '/somewhere'
  end

  private

  def stub_user(opts)
    user = stub(opts)
    @controller.stubs(:user => user)
  end

  test '#use flashes with notice when successfully use a user credit' do
    sign_in_admin
    stub_user(:use_credit => true)
    put :use, :user_id => 42
    assert flash[:notice]
  end

  test '#use flashes with alert when fails to use a user credit' do
    sign_in_admin
    stub_user(:use_credit => false)
    put :use, :user_id => 42
    assert flash[:alert]
  end

  test '#use redirects back' do
    sign_in_admin
    stub_user(:use_credit => true)
    put :use, :user_id => 42
    assert_redirected_to '/somewhere'
  end
end
