class CreateContributionRates < ActiveRecord::Migration[7.0]
  def change
    create_table :contribution_rates do |t|
      t.integer :time_period_id
      t.integer :rate_classification_id
      t.integer :employee_classification_id
      t.string :name
      t.decimal :rate

      t.timestamps
    end
  end
end
