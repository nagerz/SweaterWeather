require 'rails_helper'

RSpec.describe Antipode do
  before :each do
    url1 = 'https://maps.googleapis.com/maps/api/geocode/json?address=hongkong&key=AIzaSyASZYL_UTIJOEIrJzKbdn9DmAcFjo2Svo0'
    filename1 = 'hongkong_geocode_data.json'
    stub_get_json(url1, filename1)

    url2 = 'http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611'
    filename2 = 'hongkong_antipode_data.json'
    stub_get_json(url2, filename2)

    url3 = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyASZYL_UTIJOEIrJzKbdn9DmAcFjo2Svo0&latlng=-22.3193039,-65.8306389'
    filename3 = 'jujuy_reverse_geocode_data.json'
    stub_get_json(url3, filename3)
  end

  it 'has location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.location).to eq("hongkong")
  end

  it 'has search location' do


    antipode = Antipode.new('hongkong')

    expect(antipode.search_location).to eq("Hong Kong")
  end

  it 'can find antipode city coordinates' do
    expected = {
            "lat": -22.3193039,
            "long": -65.8306389
        }

    antipode = Antipode.new('hongkong')

    expect(antipode.antipode_coordinates).to eq(expected)
  end

  it 'can find antipode city location' do
    #expected = 'La Quiaca'
    expected = 'Jujuy'

    antipode = Antipode.new('hongkong')

    expect(antipode.location_name).to eq(expected)
  end

  it 'can find forecast for given antipode city' do
    url = 'https://api.darksky.net/forecast/1d96407050cb8bcf57fe632453b34828/-22.3193039,-65.8306389'
    filename = 'lapaz_darksky_data.json'
    stub_get_json(url, filename)

    antipode = Antipode.new('hongkong')

    expect(antipode.forecast).to have_key(:summary)
    expect(antipode.forecast).to have_key(:current_temperature)
  end
end
