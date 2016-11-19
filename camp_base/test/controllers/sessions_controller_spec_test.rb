require 'test_helper'

describe "SessionsController", "spec-style" do
  include CampBase::UserExpectations

  let(:user)  { users(:admin) }

  describe "POST :create" do
    it "logs the the user in with good credentials" do
      post login_url, params: { login: user.login, password: "secret" }
      expect(user).must_be_logged_in
    end

    it "does not log the user in with bad credentials" do
      post login_url, params: { login: user.login, password: "invalid" }
      expect(response).must_not_be_logged_in
    end
  end

  describe "DELETE :destroy" do
    it "logout ends the user's session" do
      log_in_as(user)
      delete logout_url
      expect(response).must_not_be_logged_in
    end
  end

  private

  def log_in_as(user)
    post login_url, params: { login: user.login, password: "secret" }
  end
end
