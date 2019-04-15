require 'rails_helper'

describe 'Antipode API' do
  context 'Endpoints' do
    it 'can find an antipode with a given location' do
      get '/api/v1/antipode?loc=hongkong'

      expect(response).to be_successful

      antipode = JSON.parse(response.body)

      expect(antipode).to have_key("data")
      expect(antipode["data"]).to have_key("id")
      expect(antipode["data"]["id"]).to eq("1")
      expect(antipode["data"]).to have_key("type")
      expect(antipode["data"]["type"]).to eq("antipode")
      expect(antipode["data"]).to have_key("attributes")
      expect(antipode["data"]["attributes"]).to have_key("location_name")
      expect(antipode["data"]["attributes"]).to have_key("forecast")
      expect(antipode["data"]["attributes"]["forecast"]).to have_key("summary")
      expect(antipode["data"]["attributes"]["forecast"]).to have_key("current_temperature")
      expect(antipode["data"]["attributes"]).to have_key("search_location")
      expect(antipode["data"]["attributes"]["search_location"]).to eq("Hong Kong")
    end
  end
end
