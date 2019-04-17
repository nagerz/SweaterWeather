class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :authenticate!

  def index
    render json: FavoriteSerializer.new(user).favorites_weather
  end

  def create
    if request_city
      if favorite_unique?(user, request_city)
        user.favorites.create(city: request_city)
        render json: "#{request_city.city} favorited".to_json, status: 200
      else
        render json: "Already favorited".to_json, status: :bad_request
      end
    else
      render json: "Bad/Missing location or city".to_json, status: :bad_request
    end
  end

  def destroy
    if request_city
      cities = user.cities.where(city: request_city.city)
      if cities.empty?
        render json: "Bad/Missing location or city".to_json, status: :bad_request
      else
        user.favorites.where(city: cities).destroy_all
        render json: FavoriteSerializer.new(user).favorites_weather
      end
    else
      render json: "Bad/Missing location or city".to_json, status: :bad_request
    end
  end

  private

  def user
    User.find_by(api_key: favorite_params[:api_key])
  end

  def favorite_params
    params.permit(:api_key, :location, :city)
  end

  def request_city
    if favorite_params[:location]
      find_city_by_query(favorite_params[:location])
    elsif favorite_params[:city]
      find_city_by_id(favorite_params[:city])
    end
  end

  def find_city_by_query(query)
    City.find_or_create_by(query: query) do |city|
      city.lat = geodata[:geo_lat]
      city.long = geodata[:geo_long]
      city.city = geodata[:geo_city]
      city.state = geodata[:geo_state]
    end
  end

  def find_city_by_id(id)
    City.find_by(id: id)
  end

  def favorite_unique?(user, city)
    user.cities.where(city: city.city).empty?
  end

  def geodata
    data = {}
    data[:geo_lat] = geolocation[:results][0][:geometry][:location][:lat]
    data[:geo_long] = geolocation[:results][0][:geometry][:location][:lng]
    data[:geo_city] = geolocation[:results][0][:address_components][0][:long_name]
    data[:geo_state] = geolocation[:results][0][:address_components][2][:short_name]
    data
  end

  def geolocation
    @geolocation ||= geocode_service.geocode(favorite_params[:location])
  end

  def geocode_service
    GoogleMapsService.new
  end

  def authenticate!
    four_oh_four unless User.find_by(api_key: favorite_params[:api_key])
  end

end
