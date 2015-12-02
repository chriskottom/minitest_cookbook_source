require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= users(:milton)
  end

  test "barebones user must be valid" do
    assert user.valid?, "User not valid"
  end

  test "authentication with good credentials returns the user" do
    assert_equal user, User.authenticate(user.name, "secret")
  end

  test "authentication with bad credentials returns false" do
    refute User.authenticate(user.name, "derp"),
           "Authentication with bad credentials worked?"
  end

  test "last user can't be deleted" do
    User.where.not(id: user.id).destroy_all
    error = assert_raises(RuntimeError) do
      user.destroy
    end
    assert_equal "Can't delete last user", error.message
  end
end
