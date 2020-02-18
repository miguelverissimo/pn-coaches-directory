# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_17_214457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "whitelisted_clients", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.string "token"
    t.datetime "granted_on"
    t.string "granted_by"
    t.datetime "last_accessed_on"
    t.string "last_accessed_by"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wp_fitpro_directory", id: :serial, force: :cascade do |t|
    t.integer "userid"
    t.string "source", limit: 80
    t.string "fullname", limit: 255
    t.string "businessname", limit: 255
    t.string "address1", limit: 255
    t.string "address2", limit: 255
    t.string "city", limit: 255
    t.string "province", limit: 255
    t.string "postalcode", limit: 255
    t.string "country", limit: 255
    t.string "email", limit: 255
    t.string "businessphone", limit: 255
    t.string "mobilephone", limit: 255
    t.string "url", limit: 255
    t.text "specialty"
    t.integer "show_in_directory", default: 0
    t.integer "level1_status", default: 0
    t.integer "level2_status", default: 0
    t.integer "procoach_status", default: 0
    t.integer "url_last_checked"
    t.integer "url_last_status", limit: 2
  end

end
