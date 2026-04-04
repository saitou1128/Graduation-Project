class StationsController < ApplicationController
  def show
    @station = Station.find(params[:id])
    @missions = @station.missions
    @stamps = @station.stamps.includes(:user, :mission)
  end
end
