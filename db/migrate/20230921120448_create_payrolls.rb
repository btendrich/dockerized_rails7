class CreatePayrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :payrolls do |t|
      t.date :week_ending
      t.string :name
      t.boolean :submitted
      t.boolean :reconciled

      t.timestamps
    end
  end
end
