require 'rails_helper'

describe GoogleMapsService do
  it 'exists' do
    service = GoogleMapsService.new

    expect(service).to be_a(GoogleMapsService)
  end

  describe 'instance methods' do
    describe '#geocode' do
      it 'returns json with information about a given location' do
        service = GoogleMapsService.new

        response = service.geocode('denver,co')

        expect(response[:results][0][:geometry][:location][:lat]).to eq(39.7392358)
        expect(response[:results][0][:geometry][:location][:lng]).to eq(-104.990251)
        expect(response[:results][0][:address_components][0][:long_name]).to eq("Denver")
        expect(response[:results][0][:address_components][2][:short_name]).to eq("CO")
      end
    end
  end
end
