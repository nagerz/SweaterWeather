require 'rails_helper'

describe "Forecast API" do
  context "Endpoints" do
    it "can find a forecast by a location" do
      url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
      filename1 = 'denver_geocode_data.json'
      stub_get_json(url1, filename1)

      url2 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/39.7392358,-104.990251"
      filename2 = 'denver_darksky_data.json'
      stub_get_json(url2, filename2)

      search_location = 'denver,co'

      get "/api/v1/forecast?location=#{search_location}"

      forecast = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(forecast["id"]).to include("DenverCO")
      expect(forecast["attributes"]).to include("latitude")
      expect(forecast["attributes"]).to include("longitude")
      expect(forecast["attributes"]).to include("time")
      expect(forecast["attributes"]).to include("city")
      expect(forecast["attributes"]).to include("state")
      expect(forecast["attributes"]["current_weather"]).to include("current_temp")
      expect(forecast["attributes"]["current_weather"]).to include("current_summary")
      expect(forecast["attributes"]["current_weather"]).to include("current_icon")
      expect(forecast["attributes"]["current_weather"]).to include("day_0_high")
      expect(forecast["attributes"]["current_weather"]).to include("day_0_low")
      expect(forecast["attributes"]["details"]).to include("minutely_icon")
      expect(forecast["attributes"]["details"]).to include("minutely_summary")
      expect(forecast["attributes"]["details"]).to include("hourly_summary")
      expect(forecast["attributes"]["details"]).to include("apparent_temp")
      expect(forecast["attributes"]["details"]).to include("humidity")
      expect(forecast["attributes"]["details"]).to include("visibility")
      expect(forecast["attributes"]["details"]).to include("uv_index")
      expect(forecast["attributes"]["forecast"]).to include("hourly")
      expect(forecast["attributes"]["forecast"]).to include("daily")
      expect(forecast["attributes"]["forecast"]["hourly"]["0"]).to include("time")
      expect(forecast["attributes"]["forecast"]["hourly"]["0"]).to include("icon")
      expect(forecast["attributes"]["forecast"]["hourly"]["0"]).to include("temp")
      expect(forecast["attributes"]["forecast"]["hourly"]["7"]).to include("time")
      expect(forecast["attributes"]["forecast"]["hourly"]["7"]).to include("icon")
      expect(forecast["attributes"]["forecast"]["hourly"]["7"]).to include("temp")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("time")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("summary")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("icon")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("precipitation")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("high")
      expect(forecast["attributes"]["forecast"]["daily"]["1"]).to include("low")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("time")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("summary")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("icon")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("precipitation")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("high")
      expect(forecast["attributes"]["forecast"]["daily"]["5"]).to include("low")
    end
  end
end
