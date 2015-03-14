module FizzingBuzzingTests
  def test_converts_multiples_of_fifteen_to_fizzbuzz
    assert_equal 'FizzBuzz', fizz_buzz.convert(15)
    assert_equal 'FizzBuzz', fizz_buzz.convert(45)
    assert_equal 'FizzBuzz', fizz_buzz.convert(90)
  end

  def test_converts_multiples_of_five_to_buzz
    assert_equal 'Buzz', fizz_buzz.convert(5)
    assert_equal 'Buzz', fizz_buzz.convert(20)
    assert_equal 'Buzz', fizz_buzz.convert(100)
  end

  def test_converts_multiples_of_three_to_fizz
    assert_equal 'Fizz', fizz_buzz.convert(3)
    assert_equal 'Fizz', fizz_buzz.convert(18)
    assert_equal 'Fizz', fizz_buzz.convert(99)
  end
end
