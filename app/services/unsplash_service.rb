class UnsplashService
  def get_url(location)
    get_json('search/photos', location)
  end

  def get_json(url, location)
    response = conn(location).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(location)
    Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
      faraday.params['query'] = location
      faraday.params['query'] = "skyline"
      faraday.params['query'] = "city"
      faraday.params['client_id'] = ENV['UNSPLASH_ACCESS_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end
end
