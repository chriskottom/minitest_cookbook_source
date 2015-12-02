require "test_helper"

class StoreControllerTest < ActionController::TestCase
  test "GET index should respond successfully" do
    get :index
    assert_response :success
  end
end
