require 'rails_helper'

describe 'As any kind of user' do
  describe 'when I visit the home page' do
    it 'I see a title and a location search bar' do
      url1 = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
      filename1 = 'denver_geocode_data.json'
      stub_get_json(url1, filename1)

      url2 = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET_KEY']}/39.7392358,-104.990251"
      filename2 = 'denver_darksky_data.json'
      stub_get_json(url2, filename2)

	    visit root_path

      expect(page).to have_content('Sweater Weather?')

      expect(page).to have_button('Check weather')

      click_on 'Check weather'

      expect(page).to have_content('Please enter a search location')
      expect(page).to_not have_content('Details')

      expect(page).to have_button('Check weather')

      fill_in :location, with: 'denver,co'

      click_on 'Check weather'

      expect(current_path).to eq(root_path)

      expect(page).to have_content('Denver, CO')
      expect(page).to have_content('High:')
      expect(page).to have_content('Low:')
      expect(page).to have_content('Details')
    end
  end
end
