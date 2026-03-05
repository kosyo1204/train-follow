require "test_helper"

class FollowRelationshipTest < ActiveSupport::TestCase
  # Validation tests
  test "should save follow_relationship with valid data" do
    relationship = FollowRelationship.new(
      followee: users(:user_two),
      follower: users(:user_three)
    )
    assert relationship.save, "Failed to save valid follow_relationship"
  end

  test "should not save follow_relationship without followee_id" do
    relationship = FollowRelationship.new(follower: users(:user_two))
    assert_not relationship.save, "Saved follow_relationship without followee_id"
  end

  test "should not save follow_relationship without follower_id" do
    relationship = FollowRelationship.new(followee: users(:user_one))
    assert_not relationship.save, "Saved follow_relationship without follower_id"
  end

  test "should not save follow_relationship when followee_id equals follower_id" do
    user = users(:user_one)
    relationship = FollowRelationship.new(
      followee: user,
      follower: user
    )
    assert_not relationship.save, "Saved follow_relationship with same followee_id and follower_id"
    assert_includes relationship.errors[:base], 'followee_idとfollower_idは異なるユーザーである必要があります'
  end

  # Association tests
  test "follow_relationship should belong to followee" do
    relationship = follow_relationships(:one)
    assert_respond_to relationship, :followee
    assert_equal users(:user_one), relationship.followee
  end

  test "follow_relationship should belong to follower" do
    relationship = follow_relationships(:one)
    assert_respond_to relationship, :follower
    assert_equal users(:user_two), relationship.follower
  end

  # Uniqueness test (database constraint)
  test "should not create duplicate follow_relationship" do
    relationship = FollowRelationship.new(
      followee: users(:user_one),
      follower: users(:user_two)
    )
    assert_raises(ActiveRecord::RecordNotUnique) do
      relationship.save(validate: false)
    end
  end
end
