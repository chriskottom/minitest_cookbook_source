ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/pride'

require "support/session_helpers"
require "support/shopping_helpers"

class ActiveSupport::TestCase
  include SessionHelpers

  fixtures :all
end
