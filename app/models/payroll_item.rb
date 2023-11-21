=begin
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
=end

class PayrollItem < ApplicationRecord
  belongs_to :payroll
  belongs_to :source_hour, class_name: 'Hour'
  belongs_to :source_rate, class_name: 'Rate'
  belongs_to :source_rate_amount, class_name: 'RateAmount'
  belongs_to :employee
  
end
