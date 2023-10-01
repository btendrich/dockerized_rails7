class Rate < ApplicationRecord
  belongs_to :rate_classification
  has_many :rate_amounts
  
  def self.ordered_list 
    Rate.all.order(:rate_classification_id).order(:short_code)
  end
end
