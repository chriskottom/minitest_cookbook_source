require 'test_helper'
require 'fizz_buzz_pop'

class FizzBuzzPopTest < Minitest::Test
  include FizzingBuzzingTests

  def test_converts_multiples_of_one_hundred_five_to_fizzbuzzpop
    assert_equal 'FizzBuzzPop', fizz_buzz.convert(105)
    assert_equal 'FizzBuzzPop', fizz_buzz.convert(210)
    assert_equal 'FizzBuzzPop', fizz_buzz.convert(1050)
  end

  def test_converts_multiples_of_thirty_five_to_buzzpop
    assert_equal 'BuzzPop', fizz_buzz.convert(35)
    assert_equal 'BuzzPop', fizz_buzz.convert(70)
    assert_equal 'BuzzPop', fizz_buzz.convert(3500)    
  end

  def test_converts_multiples_of_twenty_one_to_fizzpop
    assert_equal 'FizzPop', fizz_buzz.convert(21)
    assert_equal 'FizzPop', fizz_buzz.convert(42)
    assert_equal 'FizzPop', fizz_buzz.convert(189)    
  end

  def test_returns_same_number_for_other_numbers
    [1, 101, 2014].each do |i|
      assert_equal i.to_s, fizz_buzz.convert(i)
    end
  end

  private

  def fizz_buzz
    @fizz_buzz ||= FizzBuzzPop.new
  end
end
