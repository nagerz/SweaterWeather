# frozen_string_literal: true

class ForecastFacade
  attr_reader :location, :forecast

  def initialize(location)
    @location = location
    @forecast = make_forecast(search_city(geodata))
  end

  def geolocation
    geocode_service.geocode(@location)
  end

  def geodata
    data = {}
    data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
    data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
    data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
    data[:geo_state] = geolocation[:results][0][:address_components][2][:short_name]
    data
  end

  def search_city(data)
    City.find_or_create_by(lat: data[:geo_lat], long: data[:geo_long]) do |city|
      city.city = data[:geo_city]
      city.state = data[:geo_state]
    end
  end

  def make_forecast(city)
    Forecast.new(@location)
  end

  def geocode_service
    GoogleMapsService.new
  end

end
