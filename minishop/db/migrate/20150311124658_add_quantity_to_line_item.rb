class AddQuantityToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity, :integer, default: 1, after: "cart_id"
  end
end
