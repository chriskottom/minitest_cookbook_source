require 'test_helper'

describe "SessionsController", "spec-style" do
  include CampBase::UserExpectations

  let(:user)  { users(:admin) }

  describe "POST :create" do
    it "logs the the user in with good credentials" do
      post :create, login: user.login, password: "secret"
      user.must_be_logged_in
    end

    it "does not log the user in with bad credentials" do
      post :create, login: user.login, password: "invalid"
      must_not_be_logged_in
    end
  end

  describe "DELETE :destroy" do
    it "logout ends the user's session" do
      log_in_user(user)
      delete :destroy
      must_not_be_logged_in
    end
  end

  private

  def log_in_user(user)
    session[:user_id] = user.id
  end
end
