=begin
  create_table "contribution_rates", force: :cascade do |t|
    t.integer "time_period_id"
    t.integer "rate_classification_id"
    t.integer "employee_classification_id"
    t.string "name"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end
class ContributionRate < ApplicationRecord
  belongs_to :time_period
  belongs_to :rate_classification
  belongs_to :employee_classification
  
end
