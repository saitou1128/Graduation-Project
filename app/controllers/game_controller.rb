class GameController < ApplicationController
  def index
    @stations = Station.order(:order_index)

    if user_signed_in?
      # ログインユーザーは DB の GameState を使う
      @game_state = current_user.game_state || current_user.create_game_state!(
        current_station: Station.order(:order_index).first,
        last_dice_result: nil,
        turn_count: 0
      )
      @current_station = @game_state.current_station
    else
      # 未ログインユーザーは session を使う
      session[:current_station_index] ||= 0
      @current_station = Station.order(:order_index)[session[:current_station_index]]
    end

    @mission = @current_station.missions.first

    if @game_state&.last_dice_result.present?
      steps = @game_state.last_dice_result

      stations = Station.order(:order_index)
      current_index = @current_station.order_index - 1
      next_index = (current_index + steps) % stations.count

      @next_station = stations[next_index]
    end

    @has_stamp = Stamp.exists?(user: current_user, station: @current_station)
    @stamp_stations = Stamp.where(user: current_user).pluck(:station_id)
  end

  def roll
    dice = rand(1..6)

    if user_signed_in?
      @game_state = current_user.game_state
      @game_state.update!(
        last_dice_result: dice,
        mission_cleared: false
      )
    else
      session[:last_dice_result] = dice
    end

    redirect_to game_path
  end

  def move
    if user_signed_in?
      @game_state = current_user.game_state
      steps = @game_state.last_dice_result

      if steps.present?
        stations = Station.order(:order_index)
        current_index = @game_state.current_station.order_index - 1
        new_index = (current_index + steps) % stations.count

        @game_state.update!(
          current_station: stations[new_index],
          turn_count: @game_state.turn_count + 1,
          last_dice_result: nil
        )
      end
    else
      # 未ログイン時
      steps = session[:last_dice_result]
      if steps.present?
        stations = Station.order(:order_index)
        current_index = session[:current_station_index] || 0
        new_index = (current_index + steps) % stations.count
        session[:current_station_index] = new_index
      end
    end

    redirect_to game_path
  end

  def mission_complete
    if user_signed_in?
      @game_state = current_user.game_state
      @current_station = @game_state.current_station
      @mission = @current_station.missions.first

      Stamp.create!(
        user: current_user,
        station: @current_station,
        mission: @mission
      )
      @game_state.update!(
        last_dice_result: nil,
        mission_cleared: true
      )
    end

    redirect_to game_path, notice: "ミッションをクリアしました！"
  end
end
