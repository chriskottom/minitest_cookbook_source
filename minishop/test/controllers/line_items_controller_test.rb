require "test_helper"

describe LineItemsController do
  let(:product) { products(:rspec) }

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {product_id: product.id} }

      it "saves the record and redirects to the detail page" do
        lambda {
          post :create, line_item: options
        }.must_change "LineItem.count"
        assigns(:cart).wont_be_nil
        assigns(:line_item).must_be :persisted?
        must_redirect_to root_path
        flash[:notice].must_equal "Line item was successfully created."
      end
    end
  end
end
