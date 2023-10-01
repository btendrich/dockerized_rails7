class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.string :name
      t.string :short_code
      t.string :description
      t.string :uom
      t.integer :rate_classification_id
      t.integer :sort_order

      t.timestamps
    end
  end
end
