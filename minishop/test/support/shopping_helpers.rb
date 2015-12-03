module ShoppingHelpers
  def cart
    @controller.current_cart
  end

  def add_product_to_cart(product, options = {})
    _cart = options[:cart] || cart
    line_item = _cart.add_product(product.id)
    line_item.save if options[:save]
    line_item
  end
end
