class Station < ApplicationRecord
  has_many :missions, dependent: :destroy
  has_many :stamps
  has_many :game_states_as_current,
            class_name: "GameState",
            foreign_key: "current_station_id"
end
