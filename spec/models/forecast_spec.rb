require 'rails_helper'

RSpec.describe Forecast do
  it 'has attributes' do
    forecast_data = JSON.parse(File.read('./spec/fixtures/forecast_model_data.rb'), symbolize_names: true)

    forecast = Forecast.new(forecast_data)

    expect(forecast.latitude).to eq(37.8267)
    expect(forecast.longitude).to eq(-122.4233)
    expect(forecast.time).to eq(1555201964)

    expect(forecast.currently[:current_summary]).to eq('Mostly Cloudy')
    expect(forecast.currently[:current_icon]).to eq('partly-cloudy-day')
    expect(forecast.currently[:current_temp]).to eq(62.73)
    expect(forecast.currently[:day_0_high]).to eq(65.65)
    expect(forecast.currently[:day_0_low]).to eq(50.59)

    expect(forecast.details[:apparent_temp]).to eq(62.73)
    expect(forecast.details[:humidity]).to eq(0.62)
    expect(forecast.details[:visibility]).to eq(6.57)
    expect(forecast.details[:uv_index]).to eq(1)
    expect(forecast.details[:minutely_icon]).to eq('partly-cloudy-day')
    expect(forecast.details[:minutely_summary]).to eq('Mostly cloudy for the hour.')
    expect(forecast.details[:hourly_summary]).to eq('Partly cloudy until tomorrow evening.')

    expect(forecast.forecast[:hourly][0][:time]).to eq(1555200000)
    expect(forecast.forecast[:hourly][0][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:hourly][0][:temp]).to eq(63.82)
    expect(forecast.forecast[:hourly][1][:time]).to eq(1555203600)
    expect(forecast.forecast[:hourly][1][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:hourly][1][:temp]).to eq(61.83)
    expect(forecast.forecast[:hourly][2][:time]).to eq(1555207200)
    expect(forecast.forecast[:hourly][2][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:hourly][2][:temp]).to eq(59.2)
    expect(forecast.forecast[:hourly][7][:time]).to eq(1555225200)
    expect(forecast.forecast[:hourly][7][:icon]).to eq('partly-cloudy-night')
    expect(forecast.forecast[:hourly][7][:temp]).to eq(53.87)

    expect(forecast.forecast[:daily][1][:time]).to eq(1555225200)
    expect(forecast.forecast[:daily][1][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:daily][1][:summary]).to eq('Partly cloudy throughout the day.')
    expect(forecast.forecast[:daily][1][:precipitation]).to eq(0.08)
    expect(forecast.forecast[:daily][1][:high]).to eq(59.53)
    expect(forecast.forecast[:daily][1][:low]).to eq(51.01)
    expect(forecast.forecast[:daily][5][:time]).to eq(1555570800)
    expect(forecast.forecast[:daily][5][:icon]).to eq('clear-day')
    expect(forecast.forecast[:daily][5][:summary]).to eq('Clear throughout the day.')
    expect(forecast.forecast[:daily][5][:precipitation]).to eq(0.02)
    expect(forecast.forecast[:daily][5][:high]).to eq(73.89)
    expect(forecast.forecast[:daily][5][:low]).to eq(57.15)
  end
end
