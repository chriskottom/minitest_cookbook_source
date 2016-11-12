require 'test_helper'

class MockTest < Minitest::Test
  def setup
    @mock = Minitest::Mock.new
  end

  # Method expectation with no arguments
  # Returns the value expected
  def test_expectation_with_no_arguments
    @mock.expect(:status, :awesome)
    status = @mock.status
    assert_equal :awesome, status
    assert_mock @mock
  end

  # Method expectation with explicit argument (Object)
  def test_expectation_with_specific_argument
    date = Date.parse('2015-11-07')
    @mock.expect(:status_on, :awesome, [date])
    status = @mock.status_on(date)
    assert_equal :awesome, status
    assert_mock @mock
  end

  # Method expectation with Class argument
  def test_expectation_with_class_argument 
    date = Date.parse('2015-11-08')
    @mock.expect(:status_on, :awesome, [Date])
    status = @mock.status_on(date - 1)
    assert_equal :awesome, status
    assert_mock @mock
  end

  # Method expectation with block to validate arguments
  def test_expectation_with_block_validation
    @mock.expect(:status_on, :awesome) do |date_or_time|
      date_or_time.respond_to?(:to_date) && date_or_time.to_date.year >= 2014
    end
    status = @mock.status_on(DateTime.now)
    assert_equal :awesome, status
    assert_mock @mock
  end
end
