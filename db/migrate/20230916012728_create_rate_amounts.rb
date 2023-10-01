class CreateRateAmounts < ActiveRecord::Migration[7.0]
  def change
    create_table :rate_amounts do |t|
      t.integer :rate_id
      t.integer :time_period_id
      t.decimal :amount

      t.timestamps
    end
  end
end
