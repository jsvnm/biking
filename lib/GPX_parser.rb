class GPXParser
  @points = []

  def initialize(file_name)
    xml = Nokogiri::XML(open("#{Rails.root}/uploads/#{file_name}"))
    @points = xml.css('trkpt')
  end

  # returns a 2d array of lats and longs
  def points
    @points.map do |point| {
        lat: point[:lat],
        lng: point[:lon]
    } end
  end
end