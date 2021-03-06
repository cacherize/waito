# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141209024214) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "message"
    t.datetime "deleted_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "faqs", :force => true do |t|
    t.string   "question",    :limit => 512
    t.text     "answer"
    t.integer  "sort",                       :default => 0
    t.datetime "archived_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "flags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.string   "reason"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "flags", ["user_id"], :name => "index_flags_on_user_id"

  create_table "pins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pins", ["user_id", "post_id"], :name => "index_pins_on_user_id_and_post_id", :unique => true

  create_table "post_tags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_tags", ["post_id", "tag_id"], :name => "index_post_tags_on_post_id_and_tag_id", :unique => true

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",       :limit => 512
    t.text     "description"
    t.datetime "archived_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "deleted_at"
  end

  create_table "reputations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reputable_id"
    t.string   "reputable_type"
    t.float    "value",          :default => 0.0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "suggestions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "message"
    t.integer  "response"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "support_tickets", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "reason"
    t.text     "message"
    t.datetime "resolved_at"
    t.text     "response"
    t.datetime "archived_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "public_address"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "auth_token"
    t.string   "password_digest"
    t.datetime "invitation_sent_at"
    t.boolean  "activated",              :default => false
    t.boolean  "private",                :default => false
    t.datetime "password_reset_sent_at"
    t.string   "password_reset_token"
    t.boolean  "exec",                   :default => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "avatar_url"
    t.boolean  "avatar_processed",       :default => false
    t.string   "small_avatar_url"
  end

end
