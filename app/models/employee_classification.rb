=begin
  create_table "employee_classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end
class EmployeeClassification < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :contribution_rates
end
