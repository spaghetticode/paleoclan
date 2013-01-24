require 'test_helper'

class Admin::SlotsControllerTest < ActionController::TestCase
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

  test '#index lists today slots' do
    slot = FactoryGirl.create :slot, :day => Day.today
    sign_in_admin
    get :index
    assert_equal Day.today.slots, assigns(:slots)
  end

  test '#destroy destroys the requested slot' do
    slot = FactoryGirl.create :slot
    sign_in_admin
    get :destroy, :id => slot.id
    assert_raise ActiveRecord::RecordNotFound do
      slot.reload
    end
  end

  test '#destroy redirects to slots admin page' do
    slot = FactoryGirl.create :slot
    sign_in_admin
    get :destroy, :id => slot.id
    assert_redirected_to admin_slots_path
  end
end
