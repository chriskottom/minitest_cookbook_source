require 'test_helper'
require 'fizz_buzz'

describe FizzBuzz do
  behaves_like FizzBuzzable

  let(:fizz_buzz) { FizzBuzz.new }

  it "returns the same number for other numbers" do
    [1, 101, 2014].each do |i|
      expect(fizz_buzz.convert(i)).must_equal i.to_s
    end
  end
end
