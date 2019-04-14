class DarkskyService
  def get_forecast(city)
    lat = city.lat
    long = city.long
    get_json("forecast/#{ENV['DARKSKY_SECRET_KEY']}/#{lat},#{long}")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.darksky.net/') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
