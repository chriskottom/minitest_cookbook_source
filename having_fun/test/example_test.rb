require 'test_helper'

class ExampleTest < Minitest::Test
  25.times do |i|
    define_method "test_success#{ i }" do
      assert true
    end
  end

  1.times do |i|
    define_method "test_failure#{ i }" do
      assert false
    end

    define_method "test_error#{ i }" do
      raise "Boom"
    end

    define_method "test_skip#{ i }" do
      skip "Not implemented"
    end
  end
end
