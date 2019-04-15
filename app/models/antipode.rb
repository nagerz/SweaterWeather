class Antipode
  attr_reader :location, :search_location, :location_name, :forecast, :id

  def initialize(location)
    @location = location
    @id = "1"
  end

  def search_location
    geodata[:geo_city]
  end

  def location_name
    #"#{reverse_geodata[:geo_city]}, #{reverse_geodata[:geo_country]}"
    reverse_geodata[:geo_city]
  end

  def forecast
    data = {}
    data[:summary] = forecast_data[:currently][:summary]
    data[:current_temperature] = forecast_data[:currently][:temperature]
    data
  end

  def antipode_coordinates
    antipode_service.antipode(geodata)[:data][:attributes]
  end

  private

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
    geocode_service.geocode(@location)
  end

  def reverse_geolocation
    geocode_service.reverse_geocode(antipode_coordinates)
  end

  def forecast_data
    weather_service.get_forecast(city)
  end

  def geocode_service
    GoogleMapsService.new
  end

  def antipode_service
    AntipodeService.new
  end

  def weather_service
    DarkskyService.new
  end

  def city
    City.find_or_create_by(lat: antipode_coordinates[:lat], long: antipode_coordinates[:long])
  end

end
