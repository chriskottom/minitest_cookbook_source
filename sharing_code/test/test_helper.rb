require 'minitest/autorun'
require 'support/fizz_buzz_helpers'
require 'support/fizz_buzzable'
require 'support/fizzing_buzzing_tests'

module Minitest
  class Test
    def self.behaves_like(_module)
      include _module
    end
  end
end
