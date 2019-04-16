class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :authenticate!

  def create
    user = User.find_by(api_key: params[:api_key])
    if request_city
      if favorite_unique?(user, request_city)
        user.favorites.create(city: request_city)
        render json: ("#{request_city.city} favorited").to_json, status: 200
      else
        render json: ("Already favorited").to_json, status: :bad_request
      end
    else
      render json: ("Bad/Missing location or city").to_json, status: :bad_request
    end
  end

  private

  def request_city
    if params[:location]
      find_city_by_query(params[:location])
    elsif params[:city]
      find_city_by_id(params[:city])
    end
  end

  def find_city_by_query(query)
    City.find_or_create_by(query: query) do |city|
      city.lat = geodata[:geo_lat]
      city.long = geodata[:geo_long]
      city.city = geodata[:geo_city]
    end
  end

  def find_city_by_id(id)
    City.find_by(id: id)
  end

  def favorite_unique?(user, city)
    user.favorites.where(city: city).empty?
  end

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
