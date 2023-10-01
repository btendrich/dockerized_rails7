class CreatePaychecks < ActiveRecord::Migration[7.0]
  def change
    create_table :paychecks do |t|
      t.integer :employee_id
      t.date :week_ending
      t.decimal :gross
      t.boolean :reconciled
      t.text :notes

      t.timestamps
    end
  end
end
