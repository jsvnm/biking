# encoding: utf-8

class GpsDataUploader < CarrierWave::Uploader::Base

  def extension_white_list
    %w(gpx)
  end

end
