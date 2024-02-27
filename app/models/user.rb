class User < ApplicationRecord
  # ユーザーと関係性の各カラムが１対多であることを定義
  # カラムを定義しているために、company.usersのようにid単位で取れない
  has_many :followee_relationships, class_name: 'FollowRelationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :follower_relationships, class_name: 'FollowRelationship', foreign_key: 'follower_id', dependent: :destroy

  # follow_id単位で取れるように設定
  # 中間テーブルを経由してfollow_idの数を撮りに行ける
  # SELECT `users`.* FROM `users` INNER JOIN `follow_relationships` ON `users`.`id` = `follow_relationships`.`followee_id` WHERE `follow_relationships`.`followee_id` = 1
  has_many :followee, through: :followee_relationships
  has_many :followers, through: :follower_relationships

  validates :name, presence: true, uniqueness: true
end
