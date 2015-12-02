module ShoppingHelpers
  def cart
    @controller.current_cart
  end

  def add_product_to_cart(product, options = {})
    line_item = cart.add_product(product.id)
    line_item.save if options[:save]
    line_item
  end
end
