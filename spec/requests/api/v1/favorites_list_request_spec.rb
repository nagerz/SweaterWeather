require 'rails_helper'

describe 'Favorites List API' do
  context 'Endpoints' do
    before :each do
      registration_info = {
                            email: "example@email.com",
                            password: "password",
                            password_confirmation: "password",
                            api_key: "jgn983hy48thw9begh98h4539h4"
                          }
      registration_info2 = {
                            email: "example2@email.com",
                            password: "password",
                            password_confirmation: "password",
                            api_key: "jgn983hy48thw9begh98h4539h5"
                          }

      @user = User.create(registration_info)
      @user2 = User.create(registration_info2)
      city1 = City.create(city: "Denver", state: "CO", lat: 5, long: 5, query: "denver,co")
      city2 = City.create(city: "Golden", state: "CO", lat: 5, long: 6, query: "golden,co")
      city3 = City.create(city: "Boulder", state: "CO", lat: 5, long: 5, query: "boulder,co")
      Favorite.create(user: @user, city: city1)
      Favorite.create(user: @user, city: city2)
      Favorite.create(user: @user2, city: city3)

      url1 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/5.0,5.0"
      filename1 = 'denver_darksky_data.json'
      stub_get_json(url1, filename1)

      url2 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/5.0,6.0"
      filename2 = 'golden_darksky_data.json'
      stub_get_json(url2, filename2)
    end

    describe 'can see favorites' do
      it 'with an api key' do
        body_info = {
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        get '/api/v1/favorites', params: body_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to be_a(Array)
        expect(body.count).to eq(2)
        expect(body.first).to have_key("location")
        expect(body.first["location"]).to eq("Denver, CO")
        expect(body.first).to have_key("current_weather")
        expect(body.first["current_weather"]).to have_key("current_temp")
        expect(body.first["current_weather"]["current_temp"]).to eq(73.91)
        expect(body.second["location"]).to eq("Golden, CO")
        expect(body.second["current_weather"]["current_temp"]).to eq(100)
      end
    end

    describe 'can not see favorites' do
      it 'without an api key' do
        body_info = {
                        }

        get '/api/v1/favorites', params: body_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")
      end

      it 'without bad api key' do
        body_info = {
                          "api_key": "bad_key"
                        }

        get '/api/v1/favorites', params: body_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")
      end
    end
  end
end
