ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

require "support/assertions"
require "support/expectations"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all
end
