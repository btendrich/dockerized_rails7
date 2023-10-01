class RateAmount < ApplicationRecord
  belongs_to :time_period
  belongs_to :rate
end
