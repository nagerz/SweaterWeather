require 'rails_helper'

RSpec.describe Background do
  it 'has attributes' do
    background = Background.new('denver,co')

    expect(background.urls.count).to eq(10)
    expect(background.urls.first).to include('https://images.unsplash.com/photo-')
  end
end
