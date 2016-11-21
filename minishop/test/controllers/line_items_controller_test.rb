require "test_helper"

describe LineItemsController do
  let(:product) { products(:rspec) }

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {product_id: product.id} }

      it "saves the record and redirects to the detail page" do
        assert_difference "LineItem.count" do
          post line_items_url, params: { line_item: options }
        end

        must_redirect_to root_path
        expect(flash[:notice]).must_equal "Line item was successfully created."
      end
    end
  end
end
