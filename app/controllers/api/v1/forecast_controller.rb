class Api::V1::ForecastController < ApplicationController

  def show
    search_location = params[:location]
    geolocation = GoogleMapsService.new.geocode(search_location)
    geo_lat = geolocation[:results][0][:geometry][:location][:lat]
    geo_long = geolocation[:results][0][:geometry][:location][:lng]
    geo_city = geolocation[:results][0][:address_components][0][:long_name]
    geo_state = geolocation[:results][0][:address_components][2][:short_name]

    search_city = City.find_or_create_by(lat: geo_lat, long: geo_long) do |city|
      city.city = geo_city
      city.state = geo_state
    end

    forecast = DarkskyService.new.get_forecast(search_city)

    render json: ForecastSerializer.new(forecast)
  end

  private

  def search_params
    params.permit(:id, :merchant_id, :customer_id, :status, :created_at, :updated_at)
  end

end
