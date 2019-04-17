class FavoriteSerializer
  def initialize(user)
    @user = user
  end

  def favorites
    Favorite.where(user: @user)
  end

  def location(query)
    "#{forecast(query).city}, #{forecast(query).state}"
  end

  def current_weather(query)
    forecast(query).currently
  end

  def forecast(query)
    Forecast.new(query)
  end

  def favorites_weather
    favorites.map do |favorite|
      {
        location: location(favorite.city.query),
        current_weather: current_weather(favorite.city.query)
      }
    end
  end

end
