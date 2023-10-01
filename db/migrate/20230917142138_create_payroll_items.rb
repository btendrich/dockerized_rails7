class CreatePayrollItems < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_items do |t|
      t.integer :source_hour_id
      t.integer :payroll_id
      t.integer :employee_id
      t.integer :source_rate_id
      t.integer :source_rate_amount_id
      t.decimal :amount
      t.decimal :quantity
      t.boolean :correction
      t.text :notes

      t.timestamps
    end
  end
end
