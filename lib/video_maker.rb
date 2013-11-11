class VideoMaker

  def hud_options
    # standard mapmyride frame rate:
    # 579 points / 2:10:36 = 0.739 fps

    {
        f: 'image2',
        i: 'images/%03d.png',
        r: '0.39',
        s: '200x200'
    }
  end

  def overlay_options
    {
        corner: :top_right,
        offset: '10'
    }
  end

  def initialize(batch_name)
    @batch_name = batch_name
    @output_name = "output.mov"
  end

  # turns images into video
  def generate
    generate_hud
    overlay
  end

  protected

  def generate_hud
    Dir.chdir("output/#{@batch_name}") do
      `ffmpeg -f image2 -i "images/%03d.png" -r 24 -s 200x200 video/hud.avi`
    end
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

    Dir.chdir("output/#{@batch_name}") do
      `ffmpeg -i source.mov -i hud.avi  -filter_complex '#{overlay}' "#{@output_name}"`
    end
  end

end