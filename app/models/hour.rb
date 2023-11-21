=begin
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
=end

class Hour < ApplicationRecord
  belongs_to :employee
  belongs_to :rate
  
  
end
