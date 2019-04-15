require 'rails_helper'

describe 'Antipode API' do
  context 'Endpoints' do
    it 'can find an antipode with a given location' do
      get '/api/v1/antipode?loc=hongkong'

      antipode = JSON.parse(response.body)

      expect(antipode).to be_successful

      expect(antipode).to have_key("data")
    end
  end
end
