class Api::V1::ForecastController < ApplicationController

  def show
    render json: ForecastSerializer.new(Forecast.new(search_params[:location]))
  end

  private

  def search_params
    params.permit(:location)
  end

  # def geolocation
  #   geocode_service.geocode(search_params[:location])
  # end
  #
  # def geodata
  #   data = {}
  #   data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
  #   data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
  #   data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
  #   data[:geo_state] = geolocation[:results][0][:address_components][2][:short_name]
  #   data
  # end
  #
  # def search_city(data)
  #   City.find_or_create_by(lat: data[:geo_lat], long: data[:geo_long]) do |city|
  #     city.city = data[:geo_city]
  #     city.state = data[:geo_state]
  #   end
  # end
  #
  # def forecast(city)
  #   Forecast.new(weather_service.get_forecast(city), city)
  # end
  #
  # def weather_service
  #   DarkskyService.new
  # end
  #
  # def geocode_service
  #   GoogleMapsService.new
  # end

end
