=begin
  create_table "time_periods", force: :cascade do |t|
    t.string "name"
    t.date "begins"
    t.date "ends"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class TimePeriod < ApplicationRecord
  def self.for_date(date: Date.today)
    TimePeriod.where('begins <= ?', date).where('ends >= ?', date).first
  end
end
