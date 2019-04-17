require 'rails_helper'

describe 'Favorites Delete API' do
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
      city3 = City.create(city: "Boulder", state: "CO", lat: 2, long: 3, query: "boulder,co")
      Favorite.create(user: @user, city: city1)
      Favorite.create(user: @user, city: city2)
      Favorite.create(user: @user2, city: city3)

      url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,%20CO&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
      filename1 = 'denver_geocode_data.json'
      stub_get_json(url1, filename1)

      url2 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/5.0,5.0"
      filename2 = 'denver_darksky_data.json'
      stub_get_json(url2, filename2)

      url3 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/5.0,6.0"
      filename3 = 'golden_darksky_data.json'
      stub_get_json(url3, filename3)
    end

    describe 'can delete favorite' do
      it 'with an api key' do
        list_info = {
                      "api_key": "jgn983hy48thw9begh98h4539h4"
                    }

        get '/api/v1/favorites', params: list_info

        expect(response).to be_successful
        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body).to be_a(Array)
        expect(body.count).to eq(2)
        expect(body.first["location"]).to eq("Denver, CO")
        expect(body.second["location"]).to eq("Golden, CO")

        expect(Favorite.count).to eq(3)
        expect(@user.cities.count).to eq(2)

        delete_info = {
                      "location": "denver, CO",
                      "api_key": "jgn983hy48thw9begh98h4539h4"
                    }

        delete '/api/v1/favorites', params: delete_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to be_a(Array)
        expect(body.count).to eq(1)
        expect(body.first["location"]).to eq("Golden, CO")

        expect(Favorite.count).to eq(2)
        expect(@user.cities.count).to eq(1)
      end
    end

    describe 'can not delete favorite' do
      it 'without an api key' do
        expect(Favorite.count).to eq(3)

        delete_info = {
                      "location": "denver, CO",
                    }

        delete '/api/v1/favorites', params: delete_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(Favorite.count).to eq(3)
      end

      it 'without bad api key' do
        expect(Favorite.count).to eq(3)

        delete_info = {
                      "location": "denver, CO",
                      "api_key": "bad_key"
                    }

        delete '/api/v1/favorites', params: delete_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(Favorite.count).to eq(3)
      end

      it 'without location' do
        expect(Favorite.count).to eq(3)

        delete_info = {
                      "api_key": "jgn983hy48thw9begh98h4539h4"
                    }

        delete '/api/v1/favorites', params: delete_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq("Bad/Missing location or city")

        expect(Favorite.count).to eq(3)
      end

      it 'with unfavorited location' do
        expect(Favorite.count).to eq(3)

        delete_info = {
                        "location": "boulder,co",
                        "api_key": "jgn983hy48thw9begh98h4539h4"
                      }

        delete '/api/v1/favorites', params: delete_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq("Bad/Missing location or city")

        expect(Favorite.count).to eq(3)
      end
    end
  end
end
