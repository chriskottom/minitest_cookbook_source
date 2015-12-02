require "test_helper"

describe OrdersController do
  before do
    login_as(users(:lumbergh))
  end

  let(:order) { orders(:barebones) }

  describe "GET index" do
    it "responds with :success" do
      get :index
      assigns(:orders).wont_be_empty
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get :show, id: order.id
      assigns(:order).must_equal order
      must_respond_with :success
    end
  end

  describe "GET new" do
    describe "with an empty cart" do
      it "redirects to the store with an error message" do
        get :new
        assigns(:cart).must_be_instance_of Cart
        must_redirect_to root_path
        flash[:alert].must_equal "Your cart is empty."
      end
    end

    describe "with items in the cart" do
      before do
        cart = carts(:empty)
        session[:cart_id] = cart.id
        line_item = cart.add_product(products(:rspec))
        line_item.save
      end

      it "redirects to the store with a success message" do
        get :new
        assigns(:cart).must_be_instance_of Cart
        assigns(:order).must_be_instance_of Order
        assigns(:order).must_be :new_record?
        must_respond_with :success
      end
    end
  end

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {name: "Foo", address: "Bar", email: "joe@example.com",
                       pay_type: "Credit Card"} }

      it "saves the order and redirects the user to the store with a thank you" do
        lambda {
          post :create, order: options
        }.must_change "Order.count"
        assigns(:order).must_be_instance_of Order
        assigns(:order).must_be :persisted?
        session[:cart_id].must_be_nil
        must_redirect_to root_path
        flash[:notice].must_equal "Thank you for your order."
      end
    end

    describe "with invalid parameters" do
      it "doesn't save anything and redirects the user to the order page" do
        lambda {
          post :create, order: { name: "Some guy" }
        }.wont_change "Order.count"
        assigns(:order).must_be :new_record?
        must_respond_with :success
        must_render_template "new"
      end
    end
  end
end
