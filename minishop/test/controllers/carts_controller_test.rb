require "test_helper"

class CartsControllerTest < ActionController::TestCase
  test "DELETE destroy empties the cart" do
    delete :destroy, id: cart.id
    assert_not_nil cart, assigns(:cart)
    assert_empty assigns(:cart)
    assert_redirected_to root_path
    assert_equal "Cart was successfully destroyed.", flash[:notice]
  end

  private

  def cart
    if !@cart
      @cart = carts(:empty)
      session[:cart_id] = @cart.id
    end
    @cart
  end
end
