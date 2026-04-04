class CreateStations < ActiveRecord::Migration[8.1]
  def change
    return if table_exists?(:stations)

    create_table :stations do |t|
      t.string :name
      t.integer :order_index
      t.text :description

      t.timestamps
    end
  end
end