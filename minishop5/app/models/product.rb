class Product < ActiveRecord::Base
  has_many       :line_items

  validates      :title, :description, :image_url, presence: true
  validates      :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates      :title, uniqueness: true
  validates      :image_url, format: { with: %r{\.(gif|jpg|png)\z}i,
                   :message => 'must be a GIF, JPG or PNG image' }

  default_scope  { order(updated_at: :desc) }

  before_destroy :ensure_not_referenced_by_any_line_item


  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, "Line Items present")
      false
    end
  end
end
