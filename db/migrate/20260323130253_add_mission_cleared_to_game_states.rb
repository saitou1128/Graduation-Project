class AddMissionClearedToGameStates < ActiveRecord::Migration[7.2]
  def change
    add_column :game_states, :mission_cleared, :boolean, default: true, null: false
  end
end
