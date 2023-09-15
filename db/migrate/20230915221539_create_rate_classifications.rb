class CreateRateClassifications < ActiveRecord::Migration[7.0]
  def change
    create_table :rate_classifications do |t|
      t.string :name

      t.timestamps
    end
  end
end
