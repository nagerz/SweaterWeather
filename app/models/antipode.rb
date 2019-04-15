class Antipode
  attr_reader :location, :search_location, :location_name

  def initialize(location)
    @location = location
  end

  def search_location
    geodata[:geo_city]
  end

  def location_name
    reverse_geodata
  end

  def antipode_coordinates
    antipode_service.antipode(geodata)[:data][:attributes]
  end

  private

  def reverse_geodata
    data = {}
    data[:geo_city] = reverse_geolocation[:results][0][:address_components][0][:long_name]
    data
  end

  def geodata
    data = {}
    data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
    data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
    data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
    data
  end

  def reverse_geolocation
    geocode_service.reverse_geocode(antipode_coordinates)
  end

  def geolocation
    geocode_service.geocode(@location)
  end

  def geocode_service
    GoogleMapsService.new
  end

  def antipode_service
    AntipodeService.new
  end



end
