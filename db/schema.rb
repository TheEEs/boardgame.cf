# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_11_104220) do

  create_table "activities", force: :cascade do |t|
    t.integer "user_id"
    t.string "actable_type"
    t.integer "actable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verb"
    t.integer "target_id"
    t.index ["actable_type", "actable_id"], name: "index_activities_on_actable_type_and_actable_id"
    t.index ["target_id"], name: "index_activities_on_target_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.text "content"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "writer_id"
    t.index ["game_id"], name: "index_articles_on_game_id"
    t.index ["writer_id"], name: "index_articles_on_writer_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "follower_type"
    t.integer "follower_id"
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "numbers_of_player"
    t.integer "hardness"
    t.string "image"
    t.integer "playtime"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "games_orders", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "order_id", null: false
  end

  create_table "games_tags", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "sharable_type"
    t.integer "sharable_id"
    t.index ["parent_id"], name: "index_posts_on_parent_id"
    t.index ["sharable_type", "sharable_id"], name: "index_posts_on_sharable_type_and_sharable_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_tags_on_content", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "phone"
    t.string "avatar"
    t.text "intro"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
