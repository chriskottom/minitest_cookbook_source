require "minitest/assertions"

module CampBase
  module UserAssertions
    def assert_logged_in_as(user)
      message = "Expected to be logged in as #{ user.login }"
      assert_equal user.id, session[:user_id], message
    end

    def assert_not_logged_in(*args)
      message = "Expected no user to be logged in"
      assert_nil session[:user_id], message
    end
  end
end
