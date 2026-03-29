class CreateStamps < ActiveRecord::Migration[8.1]
  def change
    create_table :stamps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :station, null: false, foreign_key: true
      t.references :mission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
