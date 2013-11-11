class GpsController < ApplicationController

  def index
    @points = GPXParser.new("1.06mi_touring_bike_on_11_9_13.gpx").points
    @images = ImageSaver.new().batch_save(@points)
  end

  def create
  end

end
