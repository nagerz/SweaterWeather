require 'rails_helper'

describe 'As any kind of user' do
  describe 'when I visit the home page' do
    it 'I see a title and a locaiton search bar' do
	    visit '/'

      expect(current_path).to be(root_path)

      expect(page).to have_content("Sweater Weather?")

      expect(page).to have_content("Search Location (City, State):")

      expect(page).to have_button('Check weather')

      click_on 'Check weather'

      expect(page).to_not have_content("Details")

      expect(current_path).to be(root_path)

      expect(page).to have_content("Please enter a search location")

      fill_in 'Location', with: 'Denver, CO'

      click_on 'Check weather'

      expect(current_path).to be(root_path)

      expect(page).to have_content("Denver, CO")
      expect(page).to have_content("High:")
      expect(page).to have_content("Low:")
      expect(page).to have_content("Details")
    end
  end
end
