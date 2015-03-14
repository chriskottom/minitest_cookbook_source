class FizzBuzzIterator
  def initialize(start = 1)
    @counter = start
    @fb = FizzBuzz.new
  end

  def next
    input = @counter
    @counter += 1
    @fb.convert(input)
  end
end
