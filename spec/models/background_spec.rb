require 'rails_helper'

RSpec.describe Background do
  it 'has attributes' do
    url1 = 'https://api.unsplash.com/search/photos?client_id=d529fa91464ace31b8cd01e8c728395ae262b623d737ac382556eb5812a590aa&query=denver,co%20skyline%20city'
    filename1 = 'background_data.json'
    stub_get_json(url1, filename1)

    background = Background.new('denver,co')

    expect(background.urls.count).to eq(10)
    expect(background.urls.first).to include('https://images.unsplash.com/photo-')
  end
end
