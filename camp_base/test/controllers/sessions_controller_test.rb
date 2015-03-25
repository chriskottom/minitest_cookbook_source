require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include CampBase::UserAssertions

  def setup
    @user = users(:admin)
  end

  test "login with good credentials should log the user in" do
    post :create, login: @user.login, password: "secret"
    # assert_equal @user.id, session[:user_id]
    assert_logged_in_as(@user)
  end

  test "login with bad credentials should not log the user in" do
    post :create, login: @user.login, password: "invalid"
    assert_nil session[:user_id]
    assert_not_logged_in
  end

  test "logout should end the user's session" do
    log_in_user(@user)
    delete :destroy
    assert_nil session[:user_id]
    assert_not_logged_in
  end

  private

  def log_in_user(user)
    session[:user_id] = user.id
  end
end
