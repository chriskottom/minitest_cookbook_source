require "test_helper"

class OrderTest < ActiveSupport::TestCase
  include ShoppingHelpers

  def order
    @order ||= orders(:barebones)
  end

  test "basic order must be valid" do
    assert order.valid?, "Order not valid"
  end

  test "#add_line_items_from_cart transfers all line items to the order" do
    cart = carts(:empty)
    item1 = add_product_to_cart(cart, products(:rspec), save: true)
    item2 = add_product_to_cart(cart, products(:crafting_rails), save: true)

    order.add_line_items_from_cart(cart)
    cart.reload
    assert_empty cart.line_items
    assert_equal [item1.id, item2.id].sort, order.line_items.ids.sort
  end
end
