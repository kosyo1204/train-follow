class FollowReletionship < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_reletionships do |t|
      t.references :followee, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index(:follow_reletionships, [:followee_id, :follower_id], unique: true)
  end
end
