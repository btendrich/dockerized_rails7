=begin
  create_table "rate_amounts", force: :cascade do |t|
    t.integer "rate_id"
    t.integer "time_period_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class RateAmount < ApplicationRecord
  belongs_to :time_period
  belongs_to :rate
end
