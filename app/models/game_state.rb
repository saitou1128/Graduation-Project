class GameState < ApplicationRecord
  belongs_to :user
  belongs_to :current_station, class_name: "Station"
end
