class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
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

      t.timestamps
    end
  end
end
