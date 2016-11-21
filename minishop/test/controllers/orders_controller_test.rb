require "test_helper"

describe OrdersController do
  include SessionHelpers
  include ShoppingHelpers::Session

  before do
    login_as(users(:lumbergh))
  end

  let(:order) { orders(:barebones) }

  describe "GET index" do
    it "responds with :success" do
      get orders_url
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get order_url(id: order.id)
      must_respond_with :success
    end
  end

  describe "GET new" do
    describe "with an empty cart" do
      it "redirects to the store with an error message" do
        get new_order_url
        expect(cart).must_be_instance_of Cart
        expect(cart).must_be_empty
        must_redirect_to root_path
        expect(flash[:alert]).must_equal "Your cart is empty."
      end
    end

    describe "with items in the cart" do
      before do
        add_product_to_cart(products(:rspec))
      end

      it "redirects to the store with a success message" do
        get new_order_url
        expect(cart).must_be_instance_of Cart
        expect(cart).wont_be_empty
        must_respond_with :success
      end
    end
  end

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {name: "Foo", address: "Bar", email: "joe@example.com",
                       pay_type: "Credit Card"} }

      it "saves the order and redirects the user to the store with a thank you" do
        assert_difference "Order.count" do
          post orders_url, params: { order: options }
        end

        expect(session[:cart_id]).must_be_nil
        must_redirect_to root_path
        expect(flash[:notice]).must_equal "Thank you for your order."
      end
    end

    describe "with invalid parameters" do
      it "doesn't save anything and redirects the user to the order page" do
        assert_no_difference "Order.count" do
          post orders_url, params: { order: { name: "Some guy" } }
        end
        must_respond_with :success
      end
    end
  end
end
