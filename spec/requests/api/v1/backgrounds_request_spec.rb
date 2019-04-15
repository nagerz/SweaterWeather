require 'rails_helper'

describe 'Background API' do
  context 'Endpoints' do
    it 'can find a list of background images by a location' do
      get '/api/v1/backgrounds?location=denver,co'

      backgrounds = JSON.parse(response.body)["data"]["attributes"]

      expect(response).to be_successful

      expect(backgrounds['urls'].count).to eq(10)
      expect(backgrounds['urls'][0]).to include("https://images.unsplash.com/photo-")
    end
  end
end
