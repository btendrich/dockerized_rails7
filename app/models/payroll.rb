=begin
  create_table "payrolls", force: :cascade do |t|
    t.date "week_ending"
    t.string "name"
    t.boolean "submitted"
    t.boolean "reconciled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class Payroll < ApplicationRecord
  
  def full_name
    "#{week_ending} - #{name}"
  end
  
  def self.ordered_list 
    Payroll.all.order(:week_ending)
  end
end
