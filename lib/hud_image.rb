require 'open-uri'
class HudImage
  URL_BASE = "http://maps.googleapis.com/maps/api/staticmap?"

  def batch_save(batch_path, gpx_data)
    # e.g. username/slug
    @batch_path = batch_path
    FileUtils.mkdir_p(image_directory)
    gpx_data.each_with_index do |data, index|
      #raise data.inspect
      save(index, data[:lat], data[:lng])
    end
    @batch_path = nil
  end

  def image_url(lat, lng)
    options = self.options.merge({
      center: "#{lat},#{lng}",
      markers: "color:blue|#{lat},#{lng}"
    })
    "#{URL_BASE}#{options.to_param}"
  end

  protected

  def image_directory
    "#{Rails.root}/output/#{@batch_path}/images"
  end

  def save(number, lat, lng)
    image_path = "#{image_directory}/#{number.to_s.rjust(3, '0')}.png"
    puts "Saving image: #{image_path}"
    open(image_path, 'wb') do |file|
      file << open(image_url(lat, lng)).read
    end
  end

  def options
    #"http://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Ccolor:red%7Clabel:C%7C40.718217,-73.998284&sensor=false&key=AIzaSyBBfQWFFtvFGXa8DJ6FkPW8biT8dp7OFJA"
    {
        zoom: 14,
        size: "150x150",
        maptype: "terrain", #"roadmap",
        key: "AIzaSyBBfQWFFtvFGXa8DJ6FkPW8biT8dp7OFJA",
        sensor: false,
        visual_refresh: true
    }
  end



end