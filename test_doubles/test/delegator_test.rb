require 'test_helper'

class DelegatorTest < Minitest::Test
  def setup
    real_array = %w(art biology chemistry)
    @array_mock = Minitest::Mock.new real_array
  end

  # Assertion passes, method call is handled by the Mock object
  def test_mock_with_expected_method
    @array_mock.expect(:empty?, true)
    assert @array_mock.empty?
    assert_mock @array_mock
  end

  # Assertions pass, method calls are handled by the Array delegator
  def test_mock_with_delegated_methods
    assert_equal 3, @array_mock.length
    assert_equal "art", @array_mock.first
    assert_equal "chemistry", @array_mock.last
    assert_mock @array_mock
  end
end
