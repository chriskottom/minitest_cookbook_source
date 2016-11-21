ENV['RAILS_ENV'] ||= 'test'
ENV['MT_RAILS_NO_AUTORUN'] = 'true'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'pry-rescue/minitest'

require 'minitest/rails'
require 'minitest/pride'

require 'minitest/rails/capybara'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
# Capybara.javascript_driver = :webkit

require "support/logging_helpers"
require "support/session_helpers"
require "support/shopping_helpers"

class ActiveSupport::TestCase
  fixtures :all
end

require 'minitest/around'
require 'database_cleaner'
DatabaseCleaner.strategy = :deletion
class Capybara::Rails::TestCase
  around do |test|
    if metadata[:js]
      DatabaseCleaner.cleaning(&test)
    else
      test.call
    end
  end
end
