require 'rails_helper'

describe 'Register API' do
  context 'Endpoints' do
    it 'can register a user with credentials' do
      registration_info = {
                            email: "example@email.com",
                            password: "password",
                            password_confirmation: "password"
                          }

      post '/api/v1/users', params: registration_info

      expect(response).to be_successful
      expect(response.status).to eq(201)

      body = JSON.parse(response.body)

      expect(body).to have_key("api_key")
    end

    describe 'can not register a user with' do
      it 'bad password confirmation' do
        registration_info = {
                              email: "example@email.com",
                              password: "password",
                              password_confirmation: "not_password"
                            }

        post '/api/v1/users', params: registration_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to_not have_key("api_key")
      end

      it 'no email' do
        registration_info = {
                              password: "password",
                              password_confirmation: "not_password"
                            }

        post '/api/v1/users', params: registration_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to_not have_key("api_key")
      end

      it 'no password' do
        registration_info = {
                              email: "example@email.com",
                              password_confirmation: "not_password"
                            }

        post '/api/v1/users', params: registration_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to_not have_key("api_key")
      end
    end
  end
end
