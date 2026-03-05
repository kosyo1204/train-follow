require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Validation tests
  test "should not save user without name" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end

  test "should save user with valid name" do
    user = User.new(name: "valid_user")
    assert user.save, "Failed to save user with valid name"
  end

  test "should not save user with duplicate name" do
    user1 = User.create(name: "duplicate_name")
    user2 = User.new(name: "duplicate_name")
    assert_not user2.save, "Saved user with duplicate name"
  end

  # Association tests
  test "user should have followee_relationships" do
    user = users(:user_one)
    assert_respond_to user, :followee_relationships
  end

  test "user should have follower_relationships" do
    user = users(:user_one)
    assert_respond_to user, :follower_relationships
  end

  test "user should have followees through followee_relationships" do
    user = users(:user_one)
    assert_respond_to user, :followees
  end

  test "user should have followers through follower_relationships" do
    user = users(:user_one)
    assert_respond_to user, :followers
  end

  test "destroying user should destroy associated followee_relationships" do
    user = users(:user_one)
    assert_difference('FollowRelationship.count', -2) do
      user.destroy
    end
  end

  test "destroying user should destroy associated follower_relationships" do
    user = users(:user_two)
    followee_count = user.follower_relationships.count
    assert_difference('FollowRelationship.count', -followee_count) do
      user.destroy
    end
  end
end
