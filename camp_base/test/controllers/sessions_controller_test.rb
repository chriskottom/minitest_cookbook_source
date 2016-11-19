require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include CampBase::UserAssertions

  def setup
    @user = users(:admin)
  end

  test "login with good credentials should log the user in" do
    post login_url, params: { login: @user.login, password: "secret" }
    assert_logged_in_as(@user)
  end

  test "login with bad credentials should not log the user in" do
    post login_url, params: { login: @user.login, password: "invalid" }
    assert_nil session[:user_id]
    assert_not_logged_in
  end

  test "logout should end the user's session" do
    log_in_as(@user)
    delete logout_url
    assert_nil session[:user_id]
    assert_not_logged_in
  end

  private

  def log_in_as(user)
    post login_url, params: { login: user.login, password: "secret" }
  end
end
