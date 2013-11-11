class VideosController < ApplicationController

  def index
  end

  def create
    Video.create!(video_params)
    redirect_to(action: :index)
  end

  def perform
    VideoProcessor.perform(Video.last.id)
    render text: 'ok'
  end

  protected

  def video_params
    params.require(:video).permit(:slug, :cam_footage, :cam_footage_cache, :gps_data, :gps_data_cache)
  end

end
