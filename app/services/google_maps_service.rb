class GoogleMapsService
  def geocode(location)
    get_json("geocode/json?address=#{location}")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |faraday|
      faraday.params['key'] = ENV['GOOGLE_PLACES_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
