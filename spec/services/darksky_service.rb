require 'rails_helper'

describe DarkskyService, :vcr do
  it 'exists' do
    service = DarkskyService.new

    expect(service).to be_a(DarkskyService)
  end

  describe 'instance methods' do
    describe '#get_forecast' do
      it 'returns json with forecast information for a given location' do
        city = City.create(city: 'Denver', state: 'CO', lat: 39.7392358, long: -104.990251)

        service = DarkskyService.new

        response = service.get_forecast(city)

        expect(response[:latitude]).to eq(39.7392358)
        expect(response[:longitude]).to eq(-104.990251)
        expect(response[:currently][:summary]).to be_a(String)
        expect(response[:currently][:temperature]).to be_a(Float)
      end
    end
  end
end
