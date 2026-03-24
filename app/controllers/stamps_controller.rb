class StampsController < ApplicationController
  def index
    @stamps = current_user.stamps.includes(:station, :mission)
    @stations = Station.order(:order_index)
  end
end
