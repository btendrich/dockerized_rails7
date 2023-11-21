=begin
  create_table "rate_classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class RateClassification < ApplicationRecord
  has_many :rates
end
