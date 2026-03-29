class User < ApplicationRecord
  has_one :game_state, dependent: :destroy
  has_many :stamps, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :initialize_game_state

  private

  def initialize_game_state
    first_station = Station.find_by(order_index: 1)

    GameState.create!(
      user: self,
      current_station: first_station,
      turn_count: 0,
      last_dice_result: nil
    )
  end
end
