class CombineItemsInEachCart < ActiveRecord::Migration
  def up
    Cart.find_each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    LineItem.where("quantity > 1" ).each do |line_item|
      line_item.quantity.times do
        LineItem.create(cart_id: line_item.cart_id, quantity: 1,
                        product_id: line_item.product_id)
      end
      line_item.destroy
    end
  end
end
