require 'test_helper'

class SlotsControllerTest < ActionController::TestCase
  test 'redirects to homepage when not logged in' do
    post :create
    assert_redirected_to root_path
  end
end
