require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "GET index should respond successfully" do
    get root_url
    assert_response :success
  end
end
