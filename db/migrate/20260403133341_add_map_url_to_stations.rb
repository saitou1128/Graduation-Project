class AddMapUrlToStations < ActiveRecord::Migration[8.1]
  def change
    add_column :stations, :map_url, :text
  end
end
