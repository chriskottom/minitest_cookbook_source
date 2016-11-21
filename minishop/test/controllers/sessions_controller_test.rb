require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login with good credentials should redirect to admin page" do
    post login_url, params: { name: "milton", password: "secret" }
    assert_equal users(:milton).id, session[:user_id]
    assert_redirected_to root_path
  end

  test "login with bad credentials redirects to the login page" do
    post login_url, params: { name: "milton", password: "invalid" }
    assert_nil session[:user_id]
    assert_redirected_to login_path
  end

  test "logout should remove the user's session variables" do
    delete logout_url
    assert_nil session[:user_id]
    assert_nil @controller.current_user
    assert_redirected_to root_path
    assert_equal "Logged out", flash[:notice]
  end
end
