class AddMissionIdToStamps < ActiveRecord::Migration[7.2]
  def change
    add_column :stamps, :mission_id, :bigint
    add_index :stamps, :mission_id
  end
end
