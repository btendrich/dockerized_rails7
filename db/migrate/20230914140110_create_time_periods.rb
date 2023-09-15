class CreateTimePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :time_periods do |t|
      t.string :name
      t.date :begins
      t.date :ends
      t.text :description

      t.timestamps
    end
  end
end
