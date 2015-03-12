require "test_helper"

class StoreControllerTest < ActionController::TestCase
  test "GET index should respond successfully" do
    get :index
    refute_empty assigns(:products)
    assert_response :success
  end
end
