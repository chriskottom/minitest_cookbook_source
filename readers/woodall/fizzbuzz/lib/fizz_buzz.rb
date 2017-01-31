class FizzBuzz
  def convert(number)
    case
      when number % 5 == 0 && number % 3 == 0
        'FizzBuzz'
      when number % 5 == 0
        'Buzz'
      when number % 3 == 0
        'Fizz'
      else
        number
      end
  end
end
