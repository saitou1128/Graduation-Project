class GameController < ApplicationController
  require 'ostruct'
  def index
    @stations = Station.order(:order_index)

    if user_signed_in?
      @game_state = current_user.game_state || current_user.create_game_state!(
        current_station: Station.order(:order_index).first,
        last_dice_result: nil,
        turn_count: 0
      )
      @current_station = @game_state.current_station
    else
      session[:current_station_index] ||= 0
      @current_station = Station.order(:order_index)[session[:current_station_index]]
      session[:mission_cleared] = true if session[:mission_cleared].nil?

      @game_state = OpenStruct.new(
        mission_cleared: session[:mission_cleared],
        last_dice_result: session[:last_dice_result]
      )
    end

    @mission = @current_station.missions.first

    @stamp_stations = Stamp.where(user: current_user).pluck(:station_id)
    @has_stamp = @stamp_stations.include?(@current_station.id)

    # ★ 次の駅の計算
    if @game_state&.last_dice_result.present?
      steps = @game_state.last_dice_result

      stations = Station.order(:order_index)
      current_index = @current_station.order_index - 1

      steps.times do
        loop do
          current_index = (current_index + 1) % stations.count
          next_station = stations[current_index]

          break unless @stamp_stations.include?(next_station.id)
        end
      end

      @next_station = stations[current_index]
    end
  end

  def roll
    dice = rand(1..6)

    if user_signed_in?
      @game_state = current_user.game_state
      @game_state.update!(
        last_dice_result: dice
      )
    else
      session[:last_dice_result] = dice
      session[:mission_cleared] = false
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

        steps.times do
          loop do
            current_index = (current_index + 1) % stations.count
            next_station = stations[current_index]

            break unless Stamp.exists?(user: current_user, station: next_station)
          end
        end

        final_station = stations[current_index]

        @game_state.update!(
          current_station: final_station,
          turn_count: @game_state.turn_count + 1,
          last_dice_result: nil,
          mission_cleared: false
        )
      end

    else
      steps = session[:last_dice_result]
      if steps.present?
        stations = Station.order(:order_index)
        current_index = session[:current_station_index] || 0
        new_index = (current_index + steps) % stations.count
        session[:current_station_index] = new_index
      end

      session[:last_dice_result] = nil
      session[:mission_cleared] = false
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
        mission: @mission,
        comment: params[:comment]   # ← 追加！
      )

      @game_state.update!(
        last_dice_result: nil,
        mission_cleared: true
      )
    end

    redirect_to game_path, notice: "ミッションをクリアしました！"
  end

end
