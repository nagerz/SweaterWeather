class AntipodeWeather
  attr_reader :forecast

  def initialize(city)
    @city = city
  end

  def forecast
    {
    summary: forecast_data[:currently][:summary],
    current_temperature: forecast_data[:currently][:temperature]
    }
  end

  private

  def forecast_data
    @forecast_data ||= weather_service.get_forecast(@city)
  end

  def weather_service
    DarkskyService.new
  end
end
