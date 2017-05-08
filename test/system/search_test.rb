require 'application_system_test_case'

class SearchTest < ApplicationSystemTestCase
  test 'searching for movies' do
    VCR.use_cassette 'search' do
      visit root_path

      fill_in 'Search', with: 'rogue one'
      click_button 'Search'

      click_link 'Rogue One: A Star Wars Story'
      assert_selector '.movie-title', text: 'Rogue One: A Star Wars Story'
    end
  end
end
