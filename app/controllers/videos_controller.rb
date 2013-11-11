class VideosController < ApplicationController

  def index
  end

  def create
    @points = GPXParser.new("1.06mi_touring_bike_on_11_9_13.gpx").points
    @images = HudImage.new().batch_save(@points)
  end

end
