require 'test_helper'
require 'fizz_buzz'

class FizzBuzzTest < Minitest::Test
  def test_converts_multiples_of_fifteen_to_fizzbuzz
    fb = FizzBuzz.new

    assert_equal 'FizzBuzz', fb.convert(15)
    assert_equal 'FizzBuzz', fb.convert(45)
    assert_equal 'FizzBuzz', fb.convert(90)
  end

  def test_converts_multiples_of_five_to_buzz
    fb = FizzBuzz.new

    assert_equal 'Buzz', fb.convert(5)
    assert_equal 'Buzz', fb.convert(20)
    assert_equal 'Buzz', fb.convert(25)
  end

  def test_converts_multiples_of_three_to_fizz
    fb = FizzBuzz.new

    assert_equal 'Fizz', fb.convert(3)
    assert_equal 'Fizz', fb.convert(12)
    assert_equal 'Fizz', fb.convert(21)
  end

  def test_returns_same_number_for_other_numbers
    fb = FizzBuzz.new

    assert_equal 4, fb.convert(4)
    assert_equal 8, fb.convert(8)
    assert_equal 22, fb.convert(22)
  end
end
