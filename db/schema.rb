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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_075555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experient_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "experiment_id"
    t.jsonb "current_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experiment_id"], name: "index_experient_users_on_experiment_id"
    t.index ["user_id"], name: "index_experient_users_on_user_id"
  end

  create_table "experiments", force: :cascade do |t|
    t.string "name", null: false
    t.json "conditions", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experient_users_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "device_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_token"], name: "index_users_on_device_token", unique: true
  end

  add_foreign_key "experient_users", "experiments"
end
