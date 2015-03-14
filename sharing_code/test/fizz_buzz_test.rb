require 'test_helper'
require 'fizz_buzz'

class FizzBuzzTest < Minitest::Test
  include FizzingBuzzingTests

  def test_returns_same_number_for_other_numbers
    [1, 101, 2014].each do |i|
      assert_equal i.to_s, fizz_buzz.convert(i)
    end
  end

  private

  def fizz_buzz
    @fizz_buzz ||= FizzBuzz.new
  end
end
