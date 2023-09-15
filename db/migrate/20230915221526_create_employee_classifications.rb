class CreateEmployeeClassifications < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_classifications do |t|
      t.string :name

      t.timestamps
    end
  end
end
