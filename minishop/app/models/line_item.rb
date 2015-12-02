class LineItem < ActiveRecord::Base
  belongs_to     :product
  belongs_to     :cart, optional: true
  belongs_to     :order, optional: true

  validates      :quantity, numericality: { greater_than_or_equal_to: 1 }

  delegate       :title, :author, :description, :image_url, :price, to: :product

  def total_price
    price * quantity
  end
end
