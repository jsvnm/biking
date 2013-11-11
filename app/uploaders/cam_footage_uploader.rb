# encoding: utf-8

class CamFootageUploader < ApplicationUploader

  def extension_white_list
    %w(mov avi)
  end

end
