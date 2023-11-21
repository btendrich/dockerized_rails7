=begin
  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "employee_classification_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.date "dob"
    t.string "affiliation_organization"
    t.string "affiliation_card_number"
    t.text "notes"
    t.string "payroll_code"
    t.boolean "payroll_active"
    t.string "keycard_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end

class Employee < ApplicationRecord
  ORGANIZATIONS = ['None','Local 1','ACT','IATSE','Other']
  scope :active, -> { where(payroll_active: true) }
  scope :inactive, -> { where(payroll_active: false) }  
  
  belongs_to :employee_classification
  
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
  
  def address
    return address1 if address2.empty?
    return address2 if address1.empty?
    return "#{address1}, #{address2}"
  end
  
  def city_state_zip
    return "#{city}, #{state} #{zip}" if !city.empty? && !state.empty? && !zip.empty?
    ""
  end
  
  def self.ordered_list 
    Employee.all.order(:employee_classification_id).order(:last_name).order(:first_name)
  end
  
end
