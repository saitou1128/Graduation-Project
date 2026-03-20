class CreateMissions < ActiveRecord::Migration[7.2]
  def change
    create_table :missions do |t|
      t.references :station, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
