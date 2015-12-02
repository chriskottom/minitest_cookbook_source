require "test_helper"

class CartTest < ActiveSupport::TestCase
  include ShoppingHelpers

  def cart
    @cart ||= carts(:empty)
  end

  test "basic cart is valid" do
    assert cart.valid?, "Cart was not valid"
  end

  test "#add_product with a new product ID creates a new line item" do
    assert_equal 0, cart.line_items.count
    product = products(:rspec)
    line_item = add_product_to_cart(cart, product)
    assert_equal product.id, line_item.product.id
    assert_equal 1, line_item.quantity
  end

  test "#add_product with a product already in the cart increments quantity" do
    product = products(:rspec)
    add_product_to_cart(cart, product, save: true)
    line_item = add_product_to_cart(cart, product)
    assert_equal product.id, line_item.product.id
    assert_equal 2, line_item.quantity    
  end

  test "#total_items returns the number of items in the cart" do
    assert_equal 0, cart.total_items

    add_product_to_cart(cart, products(:rspec), save: true)
    assert_equal 1, cart.total_items
    
    add_product_to_cart(cart, products(:crafting_rails), save: true)
    assert_equal 2, cart.total_items

    add_product_to_cart(cart, products(:rspec), save: true)
    assert_equal 3, cart.total_items
  end

  test "#total_price returns the total cost of all cart items" do
    assert_equal 0, cart.total_price

    add_product_to_cart(cart, products(:rspec), save: true)
    assert_equal products(:rspec).price, cart.total_price
    
    add_product_to_cart(cart, products(:crafting_rails), save: true)
    expected = products(:rspec).price + products(:crafting_rails).price
    assert_equal expected, cart.total_price


    line_item = add_product_to_cart(cart, products(:rspec), save: true)
    expected = (2 * products(:rspec).price) + products(:crafting_rails).price
    assert_equal expected, cart.total_price    
  end

  test "is #empty when it has no line items" do
    assert cart.empty?
  end

  test "is not #empty when it has line items" do
    add_product_to_cart(cart, products(:rspec), save: true)
    refute cart.empty?
  end

  test "#empty! removes line items from cart" do
    add_product_to_cart(cart, products(:rspec), save: true)
    add_product_to_cart(cart, products(:crafting_rails), save: true)
    refute cart.empty?

    cart.empty!
    assert cart.empty?
  end
end
