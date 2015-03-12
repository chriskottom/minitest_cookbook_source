class AddOrderIdToLineItem < ActiveRecord::Migration
  def change
    add_reference :line_items, :order, index: true
    add_foreign_key :line_items, :orders
  end
end
