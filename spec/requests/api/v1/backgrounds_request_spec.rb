require 'rails_helper'

describe 'Background API' do
  context 'Endpoints' do
    it 'can find a list of background images by a location' do
      url1 = 'https://api.unsplash.com/search/photos?client_id=d529fa91464ace31b8cd01e8c728395ae262b623d737ac382556eb5812a590aa&query=city'
      filename1 = 'background_data.json'
      stub_get_json(url1, filename1)

      get '/api/v1/backgrounds?location=denver,co'

      backgrounds = JSON.parse(response.body)["data"]["attributes"]

      expect(response).to be_successful

      expect(backgrounds['urls'].count).to eq(10)
      expect(backgrounds['urls'][0]).to include("https://images.unsplash.com/photo-")
    end
  end
end
