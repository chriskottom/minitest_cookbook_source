require 'test_helper'

describe "Stubs" do
  let(:array) { %w(aardvark bonobo chipmunk dromedary) }

  it "returns expected values within stub blocks" do
    expect(array.length).must_equal 4

    array.stub(:length, 10) do
      expect(array.length).must_equal 10
    end

    expect(array.length).must_equal 4
  end

  it "won't allow stubbing of a non-existent method" do
    stub_callable = -> { array.stub(:name, "Matz") }
    expect(stub_callable).must_raise NameError
  end
end
