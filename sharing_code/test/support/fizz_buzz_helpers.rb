module FizzBuzzHelpers
  def iterate_over(iterator, *values)
    values.each do |value|
      expect(iterator.next).must_equal value
    end
  end
end
