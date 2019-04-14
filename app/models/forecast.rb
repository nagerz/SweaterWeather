class Forecast
  attr_reader :latitude,
              :longitude,
              :time,
              :currently,
              :details,
              :forecast,
              :id,
              :city,
              :state

  def initialize(forecast_data, city)
    @id = "#{city.city}#{city.state}_#{forecast_data[:currently][:time]}"
    @city = city.city
    @state = city.state
    @latitude = forecast_data[:latitude]
    @longitude = forecast_data[:longitude]
    @time = forecast_data[:currently][:time]

    @currently = {}

    @currently[:current_temp] = forecast_data[:currently][:temperature]
    @currently[:current_summary] = forecast_data[:currently][:summary]
    @currently[:current_icon] = forecast_data[:currently][:icon]
    @currently[:day_0_high] = forecast_data[:daily][:data][0][:temperatureHigh]
    @currently[:day_0_low] = forecast_data[:daily][:data][0][:temperatureLow]

    @details = {}
    @details[:minutely_icon] = forecast_data[:minutely][:icon]
    @details[:minutely_summary] = forecast_data[:minutely][:summary]
    @details[:hourly_summary] = forecast_data[:hourly][:summary]
    @details[:apparent_temp] = forecast_data[:currently][:apparentTemperature]
    @details[:humidity] = forecast_data[:currently][:humidity]
    @details[:visibility] = forecast_data[:currently][:visibility]
    @details[:uv_index] = forecast_data[:currently][:uvIndex]

    @forecast = {}
    hourly = {}
    daily = {}

    8.times do |i|
      hourly[i] = {}
      hourly[i][:time] = forecast_data[:hourly][:data][i][:time]
      hourly[i][:icon] = forecast_data[:hourly][:data][i][:icon]
      hourly[i][:temp] = forecast_data[:hourly][:data][i][:temperature]
    end

    (1..5).each do |i|
      daily[i] = {}
      daily[i][:time] = forecast_data[:daily][:data][i][:time]
      daily[i][:summary] = forecast_data[:daily][:data][i][:summary]
      daily[i][:icon] = forecast_data[:daily][:data][i][:icon]
      daily[i][:precipitation] = forecast_data[:daily][:data][i][:precipProbability]
      daily[i][:high] = forecast_data[:daily][:data][i][:temperatureHigh]
      daily[i][:low] = forecast_data[:daily][:data][i][:temperatureLow]
    end

    @forecast[:hourly] = hourly
    @forecast[:daily] = daily
  end
end
