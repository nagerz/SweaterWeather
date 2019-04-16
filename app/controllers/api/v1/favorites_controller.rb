class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :authenticate!

  def create
    user = User.find_by(api_key: params[:api_key])
    request_city = City.find_or_create_by(query: params[:location]) do |city|
      city.lat = geodata[:geo_lat]
      city.long = geodata[:geo_long]
      city.city = geodata[:geo_city]
    end

    user.favorite.create(city: request_city)

    render json: {"success": "#{request_city.city} favorited"}, status: 200
  end

  private

  def geodata
    data = {}
    data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
    data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
    data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
    data
  end

  def geolocation
    @geolocation ||= geocode_service.geocode(params[:location])
  end

  def geocode_service
    GoogleMapsService.new
  end

end
