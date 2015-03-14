require 'test_helper'
require 'fizz_buzz_iterator'

describe FizzBuzzIterator do
  subject { FizzBuzzIterator.new }

  it 'outputs sequential FizzBuzz values starting from 1' do
    subject.next.must_equal '1'
    subject.next.must_equal '2'
    subject.next.must_equal 'Fizz'
    subject.next.must_equal '4'
    subject.next.must_equal 'Buzz'
    subject.next.must_equal 'Fizz'
  end

  describe 'when initialized with a starting value' do
    subject { FizzBuzzIterator.new(10) }

    it 'outputs sequential FizzBuzz values starting from the starting value' do
      subject.next.must_equal 'Buzz'
      subject.next.must_equal '11'
      subject.next.must_equal 'Fizz'
      subject.next.must_equal '13'
      subject.next.must_equal '14'
      subject.next.must_equal 'FizzBuzz'
    end
  end
end
