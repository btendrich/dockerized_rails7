class TimePeriod < ApplicationRecord
  def self.for_date(date: Date.today)
    TimePeriod.where('begins <= ?', date).where('ends >= ?', date).first
  end
end
