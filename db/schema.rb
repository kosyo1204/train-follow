# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_23_022928) do
  create_table "follow_reletionships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "followee_id", null: false
    t.bigint "follower_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id", "follower_id"], name: "index_follow_reletionships_on_followee_id_and_follower_id", unique: true
    t.index ["followee_id"], name: "index_follow_reletionships_on_followee_id"
    t.index ["follower_id"], name: "index_follow_reletionships_on_follower_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "follow_reletionships", "users", column: "followee_id"
  add_foreign_key "follow_reletionships", "users", column: "follower_id"
end
