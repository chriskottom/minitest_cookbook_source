require 'test_helper'

describe "Test Report Customization" do
  20.times do |i|
    it "passes #{ i }" do
      assert true
    end
  end

  it "fails once" do
    assert false
  end

  it "errors once" do
    raise "Boom"
  end

  it "skips once" do
    skip "Maybe later"
  end
end
