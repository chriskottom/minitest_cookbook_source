require 'test_helper'

describe ColoredThing do
  it "should be red" do
    colored_thing = ColoredThing.new
    expect(colored_thing.color).must_equal "red"
  end
end
