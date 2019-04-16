class AntipodeFacade
  attr_reader :search_location, :location_name, :forecast, :id

  def initialize(query)
    @query = query
    @id = "1"
    @search_location = query_city.city
    @location_name = antipode_city.city
  end

  def forecast
    AntipodeWeather.new(antipode_city).forecast
  end

  private

  def query_city
    @_query_city ||= City.find_or_create_by(query: @query) do |city|
      city.lat = geodata[:geo_lat]
      city.long = geodata[:geo_long]
      city.city = geodata[:geo_city]
    end
  end

  def antipode_city
    @_antipode_city ||= City.find_or_create_by(antipode_coordinates) do |city|
      city.query = reverse_geodata[:geo_city]
      city.city = reverse_geodata[:geo_city]
    end
  end

  def antipode_coordinates
    @_antipode_coordinates ||= antipode_service.antipode(query_city)[:data][:attributes]
  end

  def geodata
    data = {}
    data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
    data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
    data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
    data
  end

  def reverse_geodata
    data = {}
    data[:geo_city] = reverse_geolocation[:results][0][:address_components][1][:long_name]
    data[:geo_country] = reverse_geolocation[:results][0][:address_components][2][:long_name]
    data
  end

  def geolocation
    @geolocation ||= geocode_service.geocode(@query)
  end

  def reverse_geolocation
    @reverse_geolocation ||= geocode_service.reverse_geocode(antipode_coordinates)
  end

  def geocode_service
    GoogleMapsService.new
  end

  def antipode_service
    AntipodeService.new
  end

end
