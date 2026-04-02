class StampsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @stamps = current_user.stamps.includes(:station, :mission)
    @stations = Station.order(:order_index)
  end
end
