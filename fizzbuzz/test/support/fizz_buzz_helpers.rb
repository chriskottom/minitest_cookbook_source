module FizzBuzzHelpers
  def iterate_over(iterator, *values)
    while value = values.shift
      iterator.next.must_equal value
    end
  end
end
