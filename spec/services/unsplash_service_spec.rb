require 'rails_helper'

describe UnsplashService, :vcr do
  it 'exists' do
    service = UnsplashService.new

    expect(service).to be_a(UnsplashService)
  end

  describe 'instance methods' do
    describe '#get_url' do
      it 'returns json with url for a given location' do
        service = UnsplashService.new

        response = service.get_url('denver,co')

        expect(response[:results].count).to eq(10)
        expect(response[:results][0][:urls]).to have_key(:full)
      end
    end
  end
end
