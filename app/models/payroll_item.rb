class PayrollItem < ApplicationRecord
  belongs_to :payroll
  belongs_to :source_hour, class_name: 'Hour'
  belongs_to :source_rate, class_name: 'Rate'
  belongs_to :source_rate_amount, class_name: 'RateAmount'
  belongs_to :employee
  
end
