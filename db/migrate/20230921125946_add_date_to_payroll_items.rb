class AddDateToPayrollItems < ActiveRecord::Migration[7.0]
  def change
    add_column :payroll_items, :date, :string
  end
end
