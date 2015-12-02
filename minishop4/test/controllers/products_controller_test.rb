require 'test_helper'

describe ProductsController do
  before do
    login_as(users(:lumbergh))
  end

  let(:product)  { products(:rspec) }

  describe "GET index" do
    it "responds with :success" do
      get :index
      assigns(:products).wont_be_empty
      must_respond_with :success
    end
  end

  describe "GET show" do
    it "responds with :success" do
      get :show, id: product.id
      assigns(:product).must_equal product
      must_respond_with :success
    end
  end

  describe "GET new" do
    it "responds with :success" do
      get :new
      assigns(:product).must_be_instance_of Product
      assigns(:product).must_be :new_record?
      must_respond_with :success
      must_render_template partial: "_form"
    end
  end

  describe "GET edit" do
    it "responds with :success" do
      get :edit, id: product.id
      assigns(:product).must_be_instance_of Product
      assigns(:product).must_be :persisted?
      must_respond_with :success
      must_render_template partial: "_form"
    end
  end

  describe "POST create" do
    describe "with valid parameters" do
      let(:options) { {title: "Test", description: "Description",
                       image_url: "cover.gif", price: 0.99} }

      it "saves the record and redirects to the detail page" do
        lambda {
          post :create, product: options
        }.must_change "Product.count"
        assigns(:product).must_be_instance_of Product
        assigns(:product).must_be :persisted?
        must_redirect_to assigns(:product)
        flash[:notice].must_equal "Product was successfully created."
      end
    end

    describe "with invalid parameters" do
      let(:options) { {title: "RSpec Rules"} }

      it "does not save the record and re-displays the :new template" do
        lambda {
          post :create, product: options
        }.wont_change "Product.count"
        assigns(:product).must_be_instance_of Product
        assigns(:product).must_be :new_record?
        must_respond_with :success
        must_render_template :new
      end
    end
  end

  describe "PATCH update" do
    describe "with valid parameters" do
      let(:options)  { {title: "RSpec and Friends"} }

      it "updates the record and redirects to the detail page" do
        put :update, id: product.id, product: options
        assigns(:product).id.must_equal product.id
        assigns(:product).title.wont_equal product.title
        must_redirect_to assigns(:product)
        flash[:notice].must_equal "Product was successfully updated."
      end
    end

    describe "with invalid parameters" do
      let(:options)  { {price: 0} }

      it "does not update the record and re-displays the :edit template" do
        put :update, id: product.id, product: options
        assigns(:product).errors.wont_be_empty
        must_respond_with :success
        must_render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the record and redirects to the index" do
      lambda { delete :destroy, id: product.id }.must_change "Product.count", -1
      must_redirect_to products_url
      flash[:notice].must_equal "Product was successfully destroyed."
    end
  end
end
