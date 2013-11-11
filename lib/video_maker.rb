class VideoMaker

  def initialize(batch_path, cam_footage)
    @batch_path = batch_path
    @cam_footage = cam_footage
    @output_name = "output.mov"
    @hud_file_name = "hud.mov"
  end

  def hud_video_options
    # standard mapmyride frame rate:
    # 579 points / 2:10:36 = 0.739 fps

    # note: ordering matters on this hash.  The r before i makes it an input framerate flag
    # we should change how these options are stored.
    {
        f: 'image2',
        r: '0.39',
        i: 'images/%03d.png',
        s: '150x150'
    }
  end

  def overlay_options
    {
        corner: :top_right,
        offset: '10'
    }
  end

  # turns images into video
  def generate
    FileUtils.mkdir_p("#{output_directory}/video")
    generate_hud_video
    overlay
  end

  protected

  def output_directory
    "#{Rails.root}/output/#{@batch_path}"
  end

  def ffmpeg(command)
    Dir.chdir(output_directory) do
      puts "Executing: ffmpeg #{command}"
      puts `ffmpeg #{command}`
    end
  end

  # see docs at https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images
  def generate_hud_video
    flags = hud_video_options.map do |key, value|
      "-#{key} #{value}"
    end.join(' ')
    # todo: dry 150x150 against HUD image.  possible move both to video.rb
    ffmpeg "#{flags} video/#{@hud_file_name}"
  end

  def overlay
    offset = overlay_options[:offset]
    overlay = case overlay_options[:corner]
                when :top_right
                  "overlay=main_w-overlay_w-#{offset}:#{offset}"
                when :bottom_right
                  "overlay=main_w-overlay_w-#{offset}:main_h-overlay_h-#{offset}"
                when :bottom_left
                  "overlay=#{offset}:main_h-overlay_h-#{offset}"
                when :top_left
                  "overlay=#{offset}:#{offset}"
              end

    ffmpeg "-i #{@cam_footage.url} -i video/#{@hud_file_name} -filter_complex '#{overlay}' 'video/#{@output_name}'"
  end

end