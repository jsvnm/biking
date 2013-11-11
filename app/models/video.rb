class Video < ActiveRecord::Base

  validates_presence_of :slug, :cam_footage, :gps_data

  validates_uniqueness_of :slug

  mount_uploader :cam_footage, VideoUploader
  mount_uploader :output_video, VideoUploader
  mount_uploader :gps_data, GpsDataUploader

  after_create do
    Resque.enqueue(VideoProcessor, self.id)
  end

end
