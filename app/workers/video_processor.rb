class VideoProcessor
  @queue = :video_processing_queue

  def self.perform(video_id)
    video = Video.find(video_id)
    video.update_attributes!(state: 'Beginning Work', processing_began_at: Time.now)

    points = GPXParser.new(video.gps_data.url).points
    video.update_attributes!(state: "Parsed #{points.count} points")

    HudImage.new.batch_save(video.slug, points)
    video.update_attributes!(state: "Generated #{points.count} images")

    video.output_video = VideoMaker.new(video.slug, video.cam_footage).generate
    video.update_attributes!(state: "Video has been processed", processing_finished_at: Time.now)
  end

end