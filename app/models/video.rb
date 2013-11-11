class Video < ActiveRecord::Base

  mount_uploader :cam_footage, CamFootageUploader
  mount_uploader :gps_data, GpsDataUploader

end
