require 'test_helper'
require 'fizz_buzz_iterator'

describe FizzBuzzIterator do
  include FizzBuzzHelpers

  let(:iterator) { FizzBuzzIterator.new }

  it 'outputs sequential FizzBuzz values starting from 1' do
    expected_values = %w(1 2 Fizz 4 Buzz Fizz)
    verify_iterator_values iterator, *expected_values
  end

  describe 'when initialized with a starting value' do
    let(:iterator) { FizzBuzzIterator.new(10) }

    it 'outputs sequential FizzBuzz values starting from the starting value' do
      expected_values = %w(Buzz 11 Fizz 13 14 FizzBuzz)
      verify_iterator_values iterator, *expected_values
    end
  end
end
