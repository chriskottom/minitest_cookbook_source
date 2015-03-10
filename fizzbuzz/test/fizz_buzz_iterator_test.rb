require 'test_helper'
require 'fizz_buzz_iterator'

describe FizzBuzzIterator do
  include FizzBuzzHelpers

  subject { FizzBuzzIterator.new }

  it 'outputs sequential FizzBuzz values starting from 1' do
    expected = %w(1 2 Fizz 4 Buzz Fizz)
    iterate_over(subject, *expected)
  end

  describe 'when initialized with a starting value' do
    subject { FizzBuzzIterator.new(10) }

    it 'outputs sequential FizzBuzz values starting from the starting value' do
      iterate_over(subject, 'Buzz', '11', 'Fizz', '13', '14', 'FizzBuzz')
    end
  end
end
