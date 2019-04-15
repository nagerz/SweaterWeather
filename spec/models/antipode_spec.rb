require 'rails_helper'

RSpec.describe Antipode do
  it 'has location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.location).to eq("hongkong")
  end

  it 'has search location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.search_location).to eq("Hong Kong")
  end

  it 'can find antipode city coordinates' do
    expected = {
            "lat": -22.3193039,
            "long": -65.8306389
        }

    antipode = Antipode.new('hongkong')

    expect(antipode.antipode_coordinates).to eq(expected)
  end

  it 'can find antipode city location' do
    #expected = 'La Quiaca'
    expected = 'Jujuy'

    antipode = Antipode.new('hongkong')

    expect(antipode.location_name).to eq(expected)
  end

  it 'can find forecast for given antipode city' do
    antipode = Antipode.new('hongkong')

    expect(antipode.forecast).to have_key(:summary)
    expect(antipode.forecast).to have_key(:current_temperature)
  end
end
