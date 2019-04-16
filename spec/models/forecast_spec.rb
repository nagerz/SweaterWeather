require 'rails_helper'

RSpec.describe Forecast do
  it 'has attributes' do
    url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
    filename1 = 'denver_geocode_data.json'
    stub_get_json(url1, filename1)

    url2 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/39.7392358,-104.990251"
    filename2 = 'denver_darksky_data.json'
    stub_get_json(url2, filename2)

    forecast = Forecast.new('denver,co')

    expect(forecast.id).to include("DenverCO_")
    expect(forecast.city).to eq('Denver')
    expect(forecast.state).to eq('CO')
    expect(forecast.latitude).to eq(39.7392358)
    expect(forecast.longitude).to eq(-104.990251)
    expect(forecast.time).to be_a(Integer)

    expect(forecast.currently[:current_summary]).to eq('Mostly Cloudy')
    expect(forecast.currently[:current_icon]).to eq('partly-cloudy-day')
    expect(forecast.currently[:current_temp]).to eq(73.91)
    expect(forecast.currently[:day_0_high]).to eq(74.49)
    expect(forecast.currently[:day_0_low]).to eq(45.36)

    expect(forecast.details[:apparent_temp]).to eq(73.91)
    expect(forecast.details[:humidity]).to eq(0.14)
    expect(forecast.details[:visibility]).to eq(6.88)
    expect(forecast.details[:uv_index]).to eq(4)
    expect(forecast.details[:minutely_icon]).to eq('partly-cloudy-day')
    expect(forecast.details[:minutely_summary]).to eq('Mostly cloudy for the hour.')
    expect(forecast.details[:hourly_summary]).to eq('Mostly cloudy throughout the day.')

    expect(forecast.forecast[:hourly][0][:time]).to eq(1555358400)
    expect(forecast.forecast[:hourly][0][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:hourly][0][:temp]).to eq(73)
    expect(forecast.forecast[:hourly][1][:time]).to eq(1555362000)
    expect(forecast.forecast[:hourly][1][:icon]).to eq('cloudy')
    expect(forecast.forecast[:hourly][1][:temp]).to eq(74.47)
    expect(forecast.forecast[:hourly][7][:time]).to eq(1555383600)
    expect(forecast.forecast[:hourly][7][:icon]).to eq('partly-cloudy-night')
    expect(forecast.forecast[:hourly][7][:temp]).to eq(63.55)

    expect(forecast.forecast[:daily][1][:time]).to eq(1555394400)
    expect(forecast.forecast[:daily][1][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:daily][1][:summary]).to eq('Mostly cloudy throughout the day.')
    expect(forecast.forecast[:daily][1][:precipitation]).to eq(0.05)
    expect(forecast.forecast[:daily][1][:high]).to eq(70.95)
    expect(forecast.forecast[:daily][1][:low]).to eq(41.66)
    expect(forecast.forecast[:daily][5][:time]).to eq(1555740000)
    expect(forecast.forecast[:daily][5][:icon]).to eq('partly-cloudy-day')
    expect(forecast.forecast[:daily][5][:summary]).to eq('Mostly cloudy throughout the day.')
    expect(forecast.forecast[:daily][5][:precipitation]).to eq(0.01)
    expect(forecast.forecast[:daily][5][:high]).to eq(77.58)
    expect(forecast.forecast[:daily][5][:low]).to eq(44.29)
  end
end
