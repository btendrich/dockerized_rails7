=begin
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
=end

class Rate < ApplicationRecord
  belongs_to :rate_classification
  has_many :rate_amounts
  
  def self.ordered_list 
    Rate.all.order(:rate_classification_id).order(:short_code)
  end
  
  def self.valid_rates_for_time_period_id(time_period_id: )
    RateAmount.where("time_period_id = ?", time_period_id).collect{ |x| x.rate }
  end
end
