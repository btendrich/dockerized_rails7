class AddMoreToPayrollItems < ActiveRecord::Migration[7.0]
  def change
    add_column :payroll_items, :total, :decimal
    add_column :payroll_items, :name, :string
    add_column :payroll_items, :short_code, :string
  end
end
