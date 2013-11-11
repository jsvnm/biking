# encoding: utf-8

class GpsDataUploader < ApplicationUploader

  def extension_white_list
    %w(gpx)
  end

end
