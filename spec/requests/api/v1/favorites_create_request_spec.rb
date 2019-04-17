require 'rails_helper'

describe 'Favorites Create API' do
  context 'Endpoints' do
    before :each do
      registration_info = {
                            email: "example@email.com",
                            password: "password",
                            password_confirmation: "password",
                            api_key: "jgn983hy48thw9begh98h4539h4"
                          }

      @user = User.create(registration_info)
    end

    describe 'can favorite a location with an api key' do
      before :each do
        url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
        filename1 = 'denver_geocode_data.json'
        stub_get_json(url1, filename1)
      end

      it 'for a new city' do
        favorite_info = {
                          "location": "denver,co",
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        expect(Favorite.count).to eq(0)

        post '/api/v1/favorites', params: favorite_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to eq('Denver favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.cities.first.city).to eq('Denver')
      end

      it 'for an existing city, same query' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "denver,co")

        favorite_info = {
                          "location": "denver,co",
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to eq('Denver favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.favorites.first.city).to eq(city)
      end

      it 'for an existing city, different query' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "Denver")

        favorite_info = {
                          "location": "denver,co",
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to eq('Denver favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.favorites.first.city).to_not eq(city)
        expect(@user.favorites.first.city.city).to eq('Denver')
      end

      it 'for an existing city, by id' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "Denver")

        url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=#{city.id}&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
        filename1 = 'denver_geocode_data.json'
        stub_get_json(url1, filename1)

        favorite_info = {
                          "city": city.id,
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to eq('Denver favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.favorites.first.city).to eq(city)
      end
    end

    describe 'can not favorite a city' do
      it 'no api key' do
        favorite_info = {
                          "location": "denver,co",
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(Favorite.count).to be(0)
        expect(@user.favorites.empty?).to be(true)
      end

      it 'bad api key' do
        favorite_info = {
                          "location": "denver,co",
                          "api_key": "badkey"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(Favorite.count).to be(0)
        expect(@user.favorites.empty?).to be(true)
      end

      it 'no location key' do
        favorite_info = {
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq('Bad/Missing location or city')

        expect(Favorite.count).to be(0)
        expect(@user.favorites.empty?).to be(true)
      end

      it 'bad city key' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "Denver")

        favorite_info = {
                          "city": city.id + 1,
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq('Bad/Missing location or city')

        expect(Favorite.count).to be(0)
        expect(@user.favorites.empty?).to be(true)
      end

      it 'city already favorited' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "denver,co")
        Favorite.create(user: @user, city: city)

        favorite_info = {
                          "location": "denver,co",
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq('Already favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.favorites.count).to eq(1)
      end

      it 'city already favorited with different query' do
        city = City.create(city: "Denver", lat: 5, long: 5, query: "denver,co")
        Favorite.create(user: @user, city: city)

        url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=Denver&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
        filename1 = 'denver_geocode_data.json'
        stub_get_json(url1, filename1)

        favorite_info = {
                          "location": "Denver",
                          "api_key": "jgn983hy48thw9begh98h4539h4"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to eq('Already favorited')

        expect(Favorite.count).to eq(1)
        expect(@user.favorites.count).to eq(1)
      end
    end
  end
end
