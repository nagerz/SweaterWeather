require 'rails_helper'

describe AntipodeService, :vcr do
  it 'exists' do
    service = AntipodeService.new

    expect(service).to be_a(AntipodeService)
  end

  describe 'instance methods' do
    describe '#antipode' do
      it 'returns json with antipode coordinates for a given location' do
        geodata = {:geo_lat=>22.3193039, :geo_long=>114.1693611, :geo_city=>"Hong Kong"}

        expected = {
                    "lat": -22.3193039,
                    "long": -65.8306389
                }

        service = AntipodeService.new

        response = service.antipode(geodata)

        expect(response[:data][:attributes]).to eq(expected)
      end
    end
  end
end
