require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  include ShoppingHelpers::Session

  test "DELETE destroy empties the cart" do
    delete cart_url
    refute_nil cart
    assert_empty cart
    assert_redirected_to root_path
    assert_equal "Cart was successfully destroyed.", flash[:notice]
  end
end
