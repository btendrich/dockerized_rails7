class CreateHours < ActiveRecord::Migration[7.0]
  def change
    create_table :hours do |t|
      t.date :date
      t.integer :hour
      t.datetime :when
      t.integer :employee_id
      t.integer :rate_id
      t.decimal :quantity
      t.boolean :correction
      t.text :notes

      t.timestamps
    end
  end
end
