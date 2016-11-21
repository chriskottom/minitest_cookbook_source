module ShoppingHelpers
  def add_product_to_cart(product, options = {})
    _cart = options[:cart]
    line_item = _cart.add_product(product.id)
    line_item.save if options[:save]
    line_item
  end

  # Helper methods for Rails 5 controller tests should manipulate
  # system state by way of controller actions whenever possible.
  module Session
    def cart
      @controller.current_cart
    end

    def add_product_to_cart(product)
      post line_items_url, params: { line_item: { product_id: product.id } }
    end
  end
end
