ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Settingsup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

require 'mocha/setup'

class ActionController::TestCase
  include Devise::TestHelpers
end

class Settings
  @factory = FactoryGirl.create(:settings)

  def method_missing(name, *args, &block)
    @factory.send name, *args, &block
  end
end

def sign_in_user
  sign_in :user, FactoryGirl.create(:user)
end

def sign_in_admin
  sign_in :user, FactoryGirl.create(:admin)
end