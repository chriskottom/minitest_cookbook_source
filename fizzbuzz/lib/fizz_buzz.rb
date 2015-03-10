class FizzBuzz
  def convert(number)
    bad_argument unless number.is_a?(Fixnum) && number > 0

    if number % 15 == 0
      "FizzBuzz"
    elsif number % 5 == 0
      "Buzz"
    elsif number % 3 == 0
      "Fizz"
    else
      number.to_s
    end
  end

  private

  def bad_argument
    raise ArgumentError, "can't FizzBuzz that"
  end
end
