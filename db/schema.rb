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

ActiveRecord::Schema.define(version: 20180109143058) do

  create_table "publications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "serial_id", null: false
    t.string "title", limit: 256, null: false
    t.date "date_min", null: false
    t.date "date_max", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date_max"], name: "index_publications_on_date_max"
    t.index ["date_min"], name: "index_publications_on_date_min"
    t.index ["serial_id", "title"], name: "index_publications_on_serial_id_and_title", unique: true
  end

  create_table "push_notification_fetch_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "push_notification_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["push_notification_id"], name: "fk_rails_421d5f1aa3"
  end

  create_table "push_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "subscription_id", null: false
    t.bigint "publication_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "fk_rails_2c34333f1c"
    t.index ["subscription_id"], name: "fk_rails_e5848ada5f"
  end

  create_table "serials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_worker_push_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.string "registration_id", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "registration_id"], name: "index_sw_push_subscriptions_on_user_id_and_registration_id", unique: true
    t.index ["user_id"], name: "index_service_worker_push_subscriptions_on_user_id"
  end

  create_table "subscription_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "serial_id", null: false
    t.string "action", limit: 8, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_id"], name: "index_subscription_histories_on_serial_id"
    t.index ["user_id"], name: "index_subscription_histories_on_user_id"
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "serial_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_id"], name: "fk_rails_0810c041de"
    t.index ["user_id", "serial_id"], name: "index_subscriptions_on_user_id_and_serial_id", unique: true
  end

  create_table "twitter_auths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "uid", null: false
    t.string "nickname", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_twitter_auths_on_uid", unique: true
    t.index ["user_id"], name: "index_twitter_auths_on_user_id", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "publications", "serials", on_update: :cascade, on_delete: :cascade
  add_foreign_key "push_notification_fetch_logs", "push_notifications", on_update: :cascade, on_delete: :cascade
  add_foreign_key "push_notifications", "publications", on_update: :cascade, on_delete: :cascade
  add_foreign_key "push_notifications", "service_worker_push_subscriptions", column: "subscription_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "service_worker_push_subscriptions", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "subscriptions", "serials", on_update: :cascade, on_delete: :cascade
  add_foreign_key "subscriptions", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "twitter_auths", "users", on_update: :cascade, on_delete: :cascade
end
