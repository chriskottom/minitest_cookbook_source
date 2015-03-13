ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/pride'

require 'minitest/rails/capybara'
Capybara.default_wait_time = 1

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

# Capybara.javascript_driver = :webkit

require "support/session_helpers"
require "support/shopping_helpers"

class ActiveSupport::TestCase
  include SessionHelpers

  fixtures :all
end
