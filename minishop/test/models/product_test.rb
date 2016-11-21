require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:barebones)
  end

  test "barebones product is valid" do
    assert @product.valid?, "Product was not valid"
  end

  test "needs an image file with a proper extension" do
    valid_images = %w(foo.gif foo.jpg foo.png foo.PNG)
    valid_images.each do |filename|
      @product.image_url = filename
      assert @product.valid?, "Product was not valid"
    end

    invalid_images = %w(foo.bmp foo.svg foopng)
    invalid_images.each do |filename|
      @product.image_url = filename
      assert @product.invalid?, "Product was not invalid"
      assert_includes @product.errors[:image_url], "must be a GIF, JPG or PNG image"
    end
  end

  test "default_scope is ordered by most recently updated" do
    rspec = products(:rspec)
    rails = products(:crafting_rails)
    rspec.update(updated_at: 1.year.ago)

    results = Product.all
    expect(results.find_index(rspec)).must_be :>, results.find_index(rails)
  end

  test "can delete record if not associated with LineItems" do
    @product.line_items.clear
    assert_empty @product.line_items
    assert_difference "Product.count", -1 do
      @product.destroy
    end
    assert @product.destroyed?, "Product was not destroyed"
  end

  test "can't delete record if associated with LineItems" do
    line_item = @product.line_items.create
    assert_no_difference "Product.count" do
      @product.destroy
    end
    assert @product.persisted?, "Product was not persisted"
    assert_includes @product.errors[:base],  "Line Items present"
  end
end
