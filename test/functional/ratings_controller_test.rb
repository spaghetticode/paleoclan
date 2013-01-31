require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  test '#new redirects when no user' do
    get :new
    assert_redirected_to root_path
  end

  test'#new redirects when user cannot leave feedback' do
    sign_in_user
    @controller.stubs(:rating_allowed?).returns(false)
    get :new
    assert_redirected_to root_path
  end

  test '#new is successful when user can leave feedback' do
    sign_in_user
    @controller.stubs(:rating_allowed?).returns(true)
    get :new
    assert_response :success
  end

  test '#create saves a new rating' do
    sign_in_user
    @controller.stubs(:rating_allowed?).returns(true)
    post :create, :value => 3
    new_rating = assigns(:rating)
    assert new_rating.kind_of?(Rating)
    assert_equal 3, new_rating.value
  end

  test '#update updates a rating' do
    sign_in_user
    @controller.stubs(:rating_allowed?).returns(true)
    rating = FactoryGirl.create :rating, :user => User.first, :value => 4
    put :update, :value => 1, :id => rating.id
    assert_equal assigns(:rating), rating
    assert_equal 1, rating.reload.value
  end
end
