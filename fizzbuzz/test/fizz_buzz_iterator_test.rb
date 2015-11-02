require 'test_helper'
require 'fizz_buzz_iterator'

describe FizzBuzzIterator do
  subject { FizzBuzzIterator.new }

  it 'outputs sequential FizzBuzz values starting from 1' do
    expect(subject.next).must_equal '1'
    expect(subject.next).must_equal '2'
    expect(subject.next).must_equal 'Fizz'
    expect(subject.next).must_equal '4'
    expect(subject.next).must_equal 'Buzz'
    expect(subject.next).must_equal 'Fizz'
  end

  describe 'when initialized with a starting value' do
    subject { FizzBuzzIterator.new(10) }

    it 'outputs sequential FizzBuzz values starting from the starting value' do
      expect(subject.next).must_equal 'Buzz'
      expect(subject.next).must_equal '11'
      expect(subject.next).must_equal 'Fizz'
      expect(subject.next).must_equal '13'
      expect(subject.next).must_equal '14'
      expect(subject.next).must_equal 'FizzBuzz'
    end
  end
end
