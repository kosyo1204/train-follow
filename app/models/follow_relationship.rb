class FollowRelationship < ApplicationRecord
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :followee_id, presence: true
  validates :follower_id, presence: true
  validate :followee_and_follower_must_be_different

  private

  def followee_and_follower_must_be_different
    if followee_id.present? && follower_id.present? && followee_id == follower_id
      errors.add(:base, 'followee_idとfollower_idは異なるユーザーである必要があります')
    end
  end
end
