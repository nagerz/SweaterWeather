class AntipodeService
  def antipode(city)
    get_json("antipodes?lat=#{city.lat}&long=#{city.long}")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |faraday|
      faraday.headers['api_key'] = ENV['ANTIPODE_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
