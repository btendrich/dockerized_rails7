=begin
  create_table "paychecks", force: :cascade do |t|
    t.integer "employee_id"
    t.date "week_ending"
    t.decimal "gross"
    t.boolean "reconciled"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class Paycheck < ApplicationRecord
  belongs_to :employee
  
end
