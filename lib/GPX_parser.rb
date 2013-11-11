class GPXParser
  @points = []

  def initialize(file_url)
    xml = Nokogiri::XML(open(file_url))
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