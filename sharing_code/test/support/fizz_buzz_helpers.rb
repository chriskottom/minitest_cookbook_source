module FizzBuzzHelpers
  def verify_iterator_values(iterator, *values)
    values.each do |value|
      expect(iterator.next).must_equal value
    end
  end
end
