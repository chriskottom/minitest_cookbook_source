require "test_helper"

describe LineItem do
  let(:product)   { products(:rspec) }
  let(:line_item) { LineItem.new(quantity: 1, product: product) }

  it "must be valid" do
    expect(line_item).must_be :valid?
  end

  describe "#total_price" do
    it "is quantity times product price" do
      product = products(:rspec)
      line_item.product = product
      assert_equal product.price, line_item.total_price

      line_item.quantity = 2
      assert_equal 2 * product.price, line_item.total_price
    end
  end
end
