class FizzBuzzPop
  def convert(number)
    fb_result = fizz_buzz.convert(number)

    if fb_result =~ /^\d+$/
      fb_number = fb_result.to_i
      fb_number % 7 == 0 ? "Pop" : fb_result
    else
      number % 7 == 0 ? fb_result + "Pop" : fb_result
    end
  end

  private

  def fizz_buzz
    @fizz_buzz ||= FizzBuzz.new
  end
end
