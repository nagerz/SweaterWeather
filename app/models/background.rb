class Background
  attr_reader :location, :urls

  def initialize(location)
    @location = location
  end

  def urls
    service.get_url(@location)[:results].map do |result|
      result[:urls][:raw]
    end
  end

  def service
    UnsplashService.new
  end
end
