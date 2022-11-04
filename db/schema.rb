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

ActiveRecord::Schema.define(version: 2022_11_04_004508) do

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chats_count", default: 0
    t.index ["token"], name: "index_applications_on_token"
  end

  create_table "chats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number"
    t.integer "messages_count", default: 0
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "application_token"
    t.index ["application_id"], name: "index_chats_on_application_id"
    t.index ["application_token"], name: "index_chats_on_application_token"
    t.index ["number", "application_token"], name: "index_chats_on_number_and_application_token", unique: true
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "body"
    t.integer "number"
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "application_token"
    t.integer "chat_number"
    t.index ["application_token", "chat_number"], name: "index_messages_on_application_token_and_chat_number"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  add_foreign_key "chats", "applications"
  add_foreign_key "messages", "chats"
end
