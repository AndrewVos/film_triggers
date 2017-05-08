require 'application_system_test_case'

class ManageTriggersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_reset!
  end

  test 'adding triggers to a movie' do
    VCR.use_cassette 'search' do
      login_as users(:one)

      visit root_path
      fill_in 'Search', with: 'rogue one'
      click_button 'Search'
      assert_selector '.movie', text: 'Rogue One'

      Trigger.create!(user: users(:one), movie_id: 330459, label: 'contains bananas')
      Trigger.create!(user: users(:one), movie_id: 330459, label: 'loud noises')
      Trigger.create!(user: users(:two), movie_id: 330459, label: 'loud noises')

      click_link 'Rogue One: A Star Wars Story'
      assert_selector '.movie-title', text: 'Rogue One: A Star Wars Story'

      assert_selector '.movie-trigger', text: 'contains bananas x 1'
      assert_selector '.movie-trigger', text: 'loud noises x 2'

      select 'violence', from: 'Trigger'
      click_button 'Add trigger'

      assert_selector '.movie-trigger', text: 'violence x 1'
    end
  end
end
