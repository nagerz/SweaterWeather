require 'rails_helper'

describe 'Favorites API' do
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

        post '/api/v1/favorites', params: favorite_info

        expect(response).to be_successful
        expect(response.status).to eq(200)

        body = JSON.parse(response.body)

        expect(body).to eq({"success": "Denver favorited"})

        expect(@user.cities.first.city).to eq("Denver")
      end

      # it 'for an existing city' do
      #
      #   favorite_info = {
      #                     "location": "denver,co",
      #                     "api_key": "jgn983hy48thw9begh98h4539h4"
      #                   }
      #
      #   post '/api/v1/favorites', params: favorite_info
      #
      #   expect(response).to be_successful
      #   expect(response.status).to eq(200)
      #
      #   body = JSON.parse(response.body)
      #
      #   expect(body).to eq({"success": "Denver favorited"})
      #
      #   expect(@user.favorites.first.city).to eq("Denver")
      # end
    end

    describe 'can not favorite a city' do
      it 'no api key' do
        favorite_info = {
                          "location": "denver,co",
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        binding.pry
        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(@user.favorites).to be(nil)
      end

      it 'bad api key' do
        favorite_info = {
                          "location": "denver,co",
                          "api_key": "badkey"
                        }

        post '/api/v1/favorites', params: favorite_info

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        binding.pry
        body = JSON.parse(response.body)

        expect(body).to eq("Unauthorized")

        expect(@user.favorites).to be(nil)
      end
    end
  end
end
