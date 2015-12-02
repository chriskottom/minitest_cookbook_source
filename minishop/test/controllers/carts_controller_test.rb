require "test_helper"

class CartsControllerTest < ActionController::TestCase
  include ShoppingHelpers

  test "DELETE destroy empties the cart" do
    delete :destroy
    refute_nil cart
    assert_empty cart
    assert_redirected_to root_path
    assert_equal "Cart was successfully destroyed.", flash[:notice]
  end
end
