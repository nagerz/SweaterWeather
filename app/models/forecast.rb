class Forecast
  attr_reader :currently, :details, :forecast

  def initialize(forecast_data)
    @currently = {}
    @currently[:latitude] = forecast_data[:latitude]
    @currently[:longitude] = forecast_data[:longitude]
    @currently[:time] = forecast_data[:currently][:time]
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
