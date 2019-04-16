require 'rails_helper'

describe 'Login API' do
  context 'Endpoints' do
    before :each do
      registration_info = {
                            email: "example@email.com",
                            password: "password",
                            password_confirmation: "password"
                          }

      User.create(registration_info)
    end

    it 'can log in an existing user with credentials' do
      login_info = {
                      email: "example@email.com",
                      password: "password"
                    }

      post '/api/v1/sessions', params: login_info

      expect(response).to be_successful
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)

      expect(body).to have_key("api_key")
    end

    describe 'can not log in a user with' do
      it 'bad password' do
        login_info = {
                              email: "example@email.com",
                              password: "bad_password"
                            }

        post '/api/v1/sessions', params: login_info

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        body = JSON.parse(response.body)

        expect(body).to_not have_key("api_key")
      end
    end
  end
end
