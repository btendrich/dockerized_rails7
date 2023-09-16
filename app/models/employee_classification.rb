class EmployeeClassification < ApplicationRecord
  has_many :employees, dependent: :destroy
end
