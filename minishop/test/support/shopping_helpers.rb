module ShoppingHelpers
  def add_product_to_cart(cart, product, options = {})
    line_item = cart.add_product(product.id)
    line_item.save if options[:save]
    line_item
  end
end
