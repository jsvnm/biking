require 'open-uri'
class ImageSaver

  def initialize
    @url_base = "http://maps.googleapis.com/maps/api/staticmap?"
  end

  def batch_save(gpx_data)
    #FileUtils.mkdir_p(File.dirname())
    gpx_data.each_with_index do |data, index|
      #raise data.inspect
      save(index, data[:lat], data[:lng])
    end
  end

  def save(number, lat, lng)
    open("#{Rails.root}/output/test1/#{number.to_s.rjust(3, '0')}.png", 'wb') do |file|
      file << static_image(lat, lng)
    end
  end

  protected

  def options
    #"http://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Ccolor:red%7Clabel:C%7C40.718217,-73.998284&sensor=false&key=AIzaSyBBfQWFFtvFGXa8DJ6FkPW8biT8dp7OFJA"
    {
        zoom: 13,
        size: "200x200",
        maptype: "roadmap",
        key: "AIzaSyBBfQWFFtvFGXa8DJ6FkPW8biT8dp7OFJA",
        sensor: false
    }
  end

  def static_image(lat, lng)
    url = "#{@url_base}#{options.merge(center: "#{lat},#{lng}").to_param}"
    open(url).read
  end


end