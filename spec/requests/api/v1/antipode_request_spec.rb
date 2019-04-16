require 'rails_helper'

describe 'Antipode API' do
  context 'Endpoints' do
    it 'can find an antipode with a given location' do
      url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=hongkong&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
      filename1 = 'hongkong_geocode_data.json'
      stub_get_json(url1, filename1)

      url2 = 'http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611'
      filename2 = 'hongkong_antipode_data.json'
      stub_get_json(url2, filename2)

      url3 = "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['GOOGLE_PLACES_API_KEY']}&latlng=-22.3193039,-65.8306389"
      filename3 = 'jujuy_reverse_geocode_data.json'
      stub_get_json(url3, filename3)

      url4 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/-22.3193039,-65.8306389"
      filename4 = 'lapaz_darksky_data.json'
      stub_get_json(url4, filename4)

      get '/api/v1/antipode?loc=hongkong'

      expect(response).to be_successful

      antipode = JSON.parse(response.body)

      expect(antipode).to have_key("data")
      expect(antipode["data"][0]).to have_key("id")
      expect(antipode["data"][0]["id"]).to eq("1")
      expect(antipode["data"][0]).to have_key("type")
      expect(antipode["data"][0]["type"]).to eq("antipode")
      expect(antipode["data"][0]).to have_key("attributes")
      expect(antipode["data"][0]["attributes"]).to have_key("location_name")
      expect(antipode["data"][0]["attributes"]).to have_key("forecast")
      expect(antipode["data"][0]["attributes"]["forecast"]).to have_key("summary")
      expect(antipode["data"][0]["attributes"]["forecast"]).to have_key("current_temperature")
      expect(antipode["data"][0]["attributes"]).to have_key("search_location")
      expect(antipode["data"][0]["attributes"]["search_location"]).to eq("Hong Kong")
    end
  end
end
