require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = FactoryGirl.create(:user)
  end

  test 'is valid' do
    assert @user.valid?
  end
end
