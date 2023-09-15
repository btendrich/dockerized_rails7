class Employee < ApplicationRecord
=begin
  t.string :first_name
  t.string :last_name
  t.string :classification
  t.string :address1
  t.string :address2
  t.string :city
  t.string :state
  t.string :zip
  t.string :phone
  t.date :dob
  t.string :affiliation_organization
  t.string :affiliation_card_number
  t.text :notes
  t.string :payroll_code
  t.boolean :payroll_active
  t.string :keycard_number
  t.string :email
=end
  CLASSIFICATIONS = ['Basic', 'Maintenance', 'Extra', 'Retired']
  ORGANIZATIONS = ['None','Local 1','ACT','IATSE','Other']

#  validates :first_name, length: {in: 2..32 }
#  validates :last_name, length: {in: 2..32 }
#  validates :classification, inclusion: {in: CLASSIFICATIONS}
#  validates :address1, length: {maximum: 255}
#  validates :address2, length: {maximum: 255}
#  validates :city, length: {maximum: 64}
#  validates :state, length: {maximum: 2}
#  validates :zip, length: {maximum: 10}
#  validates :phone, length: {maximum: 10}
#  validates :email, length: {maximum: 255}
#  validates :affiliation_organization, inclusion: {in: ORGANIZATIONS}
#  validates :affiliation_card_number, length: {maximum: 64}
#  validates :payroll_code, length: {maximum: 64}
#  validates :keycard_number, length: {maximum: 64}
#  validates :dob, comparison: { less_than_or_equal_to: (Date.today - 18.years), message: 'must be at least 18 years old' }, unless: Proc.new { |a| a.dob.blank? }
  
  scope :active, -> { where(payroll_active: true) }
  scope :inactive, -> { where(payroll_active: false) }  
  
  def full_name
    if first_name.empty? 
      last_name
    else
      "#{last_name}, #{first_name}"
    end
  end
  
  def full_address
    result = ""
    if !address1.empty? || !city.empty? || !state.empty? || !zip.empty? 
      if address2.empty?
        result = "#{address1}, #{city}, #{state}, #{zip}"
      else
        result = "#{address1}, #{address2}, #{city}, #{state}, #{zip}"
      end
    end
    result
  end
  
end
