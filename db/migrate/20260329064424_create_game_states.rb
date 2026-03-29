class CreateGameStates < ActiveRecord::Migration[8.1]
  def change
    create_table :game_states do |t|
      t.references :user, null: false, foreign_key: true
      t.references :current_station, null: false, foreign_key: { to_table: :stations }
      t.integer :last_dice_result
      t.integer :turn_count
      t.boolean :mission_cleared, default: true, null: false

      t.timestamps
    end
  end
end
