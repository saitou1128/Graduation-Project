class CreateStations < ActiveRecord::Migration[7.2]
  def change
    create_table :stations do |t|
      t.string :name
      t.integer :order_index
      t.text :description

      t.timestamps
    end
  end
end
