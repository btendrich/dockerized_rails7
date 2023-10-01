class AdjustDateColumnOnPayrollItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :payroll_items, :date
    add_column :payroll_items, :date, :date
  end
end
