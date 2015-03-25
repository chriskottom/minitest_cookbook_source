require "minitest/spec"

module CampBase
  module UserExpectations
    def self.included(base)
      base.class_eval do
        include CampBase::UserAssertions
      end
    end

    User.infect_an_assertion :assert_logged_in_as, :must_be_logged_in, :unary
    infect_an_assertion :assert_not_logged_in, :must_not_be_logged_in
    infect_an_assertion :assert_not_logged_in, :wont_be_logged_in
  end
end
