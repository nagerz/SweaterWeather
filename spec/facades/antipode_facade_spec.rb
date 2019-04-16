require 'rails_helper'

RSpec.describe AntipodeFacade do
  before :each do
    url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=hongkong&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
    filename1 = 'hongkong_geocode_data.json'
    stub_get_json(url1, filename1)

    url2 = "http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611"
    filename2 = 'hongkong_antipode_data.json'
    stub_get_json(url2, filename2)

    url3 = "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_PLACES_API_KEY']}&latlng=-22.3193039,-65.8306389"
    filename3 = 'jujuy_reverse_geocode_data.json'
    stub_get_json(url3, filename3)
  end

  it 'has search location' do
    antipode = AntipodeFacade.new('hongkong')

    expect(antipode.search_location).to eq("Hong Kong")
  end

  it 'can find antipode city location' do
    expected = 'Jujuy'

    antipode = AntipodeFacade.new('hongkong')

    expect(antipode.location_name).to eq(expected)
  end

  it 'can find forecast for given antipode city' do
    url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/-22.3193039,-65.8306389"
    filename = 'lapaz_darksky_data.json'
    stub_get_json(url, filename)

    antipode = AntipodeFacade.new('hongkong')

    expect(antipode.forecast).to have_key(:summary)
    expect(antipode.forecast[:summary]).to eq("Clear")
    expect(antipode.forecast).to have_key(:current_temperature)
    expect(antipode.forecast[:current_temperature]).to eq(64.8)
  end
end
