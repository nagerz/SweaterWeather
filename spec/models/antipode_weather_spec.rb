require 'rails_helper'

RSpec.describe Antipode do
  before :each do
  end

  it 'has a forecast' do
    url = 'https://api.darksky.net/forecast/1d96407050cb8bcf57fe632453b34828/-22.3193039,-65.8306389'
    filename = 'lapaz_darksky_data.json'
    stub_get_json(url, filename)

    city = City.create(query: 'Jujuy', lat: -22.3193039, long: -65.8306389)

    forecast = AntipodeWeather.new(city).forecast

    expect(forecast).to have_key(:summary)
    expect(forecast[:summary]).to eq('Clear')
    expect(forecast).to have_key(:current_temperature)
    expect(forecast[:current_temperature]).to eq(64.8)
  end
end
