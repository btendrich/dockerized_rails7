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

ActiveRecord::Schema[7.0].define(version: 2023_09_21_141933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contribution_rates", force: :cascade do |t|
    t.integer "time_period_id"
    t.integer "rate_classification_id"
    t.integer "employee_classification_id"
    t.string "name"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "employee_classification_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.date "dob"
    t.string "affiliation_organization"
    t.string "affiliation_card_number"
    t.text "notes"
    t.string "payroll_code"
    t.boolean "payroll_active"
    t.string "keycard_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.date "date"
    t.integer "hour"
    t.datetime "when"
    t.integer "employee_id"
    t.integer "rate_id"
    t.decimal "quantity"
    t.boolean "correction"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paychecks", force: :cascade do |t|
    t.integer "employee_id"
    t.date "week_ending"
    t.decimal "gross"
    t.boolean "reconciled"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payroll_items", force: :cascade do |t|
    t.integer "source_hour_id"
    t.integer "payroll_id"
    t.integer "employee_id"
    t.integer "source_rate_id"
    t.integer "source_rate_amount_id"
    t.decimal "amount"
    t.decimal "quantity"
    t.boolean "correction"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total"
    t.string "name"
    t.string "short_code"
    t.date "date"
  end

  create_table "payrolls", force: :cascade do |t|
    t.date "week_ending"
    t.string "name"
    t.boolean "submitted"
    t.boolean "reconciled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_amounts", force: :cascade do |t|
    t.integer "rate_id"
    t.integer "time_period_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade do |t|
    t.string "name"
    t.string "short_code"
    t.string "description"
    t.string "uom"
    t.integer "rate_classification_id"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_periods", force: :cascade do |t|
    t.string "name"
    t.date "begins"
    t.date "ends"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
