require 'test_helper'

describe ProductsController do
  before do
    login_as(users(:lumbergh))
  end

  let(:product)  { products(:rspec) }

  describe "GET index" do
    it "responds with :success" do
      get :index
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get :show, params: { id: product.id }
      must_respond_with :success
    end
  end

  describe "GET new" do
    it "responds with :success" do
      get :new
      must_respond_with :success
    end
  end

  describe "GET edit" do
    it "responds with :success" do
      get :edit, params: { id: product.id }
      must_respond_with :success
    end
  end

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {title: "Test", description: "Description",
                       image_url: "cover.gif", price: 0.99} }

      it "saves the record and redirects to the detail page" do
        assert_difference "Product.count" do
          post :create, params: { product: options }
        end

        product = Product.order(created_at: :desc).first
        must_redirect_to product
        expect(flash[:notice]).must_equal "Product was successfully created."
      end
    end

    describe "with invalid parameters" do
      let(:options) { {title: "RSpec Rules"} }

      it "does not save the record and re-displays the :new template" do
        assert_no_difference "Product.count" do
          post :create, params: { product: options }
        end
        must_respond_with :success
      end
    end
  end

  describe "PATCH update" do
    describe "with valid parameters" do
      let(:options)  { {title: "RSpec and Friends"} }

      it "updates the record and redirects to the detail page" do
        put :update, params: { id: product.id, product: options }

        expect(product.reload.title).must_equal options[:title]
        must_redirect_to product
        expect(flash[:notice]).must_equal "Product was successfully updated."
      end
    end

    describe "with invalid parameters" do
      let(:options)  { {price: 0} }

      it "does not update the record and re-displays the :edit template" do
        put :update, params: { id: product.id, product: options }
        expect(product.reload.price).wont_equal 0
        must_respond_with :success
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the record and redirects to the index" do
      assert_difference "Product.count", -1 do
        delete :destroy, params: { id: product.id }
      end
      must_redirect_to products_url
      expect(flash[:notice]).must_equal "Product was successfully destroyed."
    end
  end
end
