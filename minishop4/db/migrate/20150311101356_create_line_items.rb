class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :product, index: true
      t.references :cart, index: true

      t.timestamps null: false
    end
    add_foreign_key :line_items, :products
    add_foreign_key :line_items, :carts
  end
end
