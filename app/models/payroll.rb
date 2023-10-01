class Payroll < ApplicationRecord
  
  def full_name
    "#{week_ending} - #{name}"
  end
  
  def self.ordered_list 
    Payroll.all.order(:week_ending)
  end
end
