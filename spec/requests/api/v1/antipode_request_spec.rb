require 'rails_helper'

describe 'Antipode API' do
  context 'Endpoints' do
    it 'can find an antipode with a given location' do
      expected = {
    "data": [
        {
            "id": "1",
            "type": "antipode",
            "attributes": {
                "location_name": "Antipode City Name",
                "forecast": {
                    "summary": "Mostly Cloudy",
                    "current_temperature": "72",
                				},
            "search_location": "Hong Kong"
            }
        }
    ]
}

      get '/api/v1/antipode?loc=hongkong'

      expect(response).to be_successful

      antipode = JSON.parse(response.body)

      expect(antipode).to have_key("data")
      expect(antipode[:data][0]).to have_key("id")
      expect(antipode[:data][0]["id"]).to eq("1")
      expect(antipode[:data][0]).to have_key("type")
      expect(antipode[:data][0]["type"]).to eq("antipode")
      expect(antipode[:data][0]).to have_key("attributes")
      expect(antipode[:data][0]["attributes"]).to have_key("location_name")
      expect(antipode[:data][0]["attributes"]).to have_key("forecast")
      expect(antipode[:data][0]["attributes"]["forecast"]).to have_key("summary")
      expect(antipode[:data][0]["attributes"]["forecast"]).to have_key("current_temperature")
      expect(antipode[:data][0]["attributes"]).to have_key("search_location")
      expect(antipode[:data][0]["attributes"]["search_location"]).to eq("Hong Kong")
    end
  end
end
