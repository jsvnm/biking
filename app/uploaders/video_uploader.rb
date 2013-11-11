# encoding: utf-8

class VideoUploader < ApplicationUploader

  def extension_white_list
    %w(mov avi)
  end

end
