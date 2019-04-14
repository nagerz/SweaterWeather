require 'rails_helper'

describe "Forecast API" do
  context "Endpoints" do
    it "can find a forecast by a location" do
      search_location = 'denver,co'

      get "/api/v1/forecast?location=#{search_location}"

      forecast = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(forecast["attributes"]["location"]).to eq("")
    end
  end
end
