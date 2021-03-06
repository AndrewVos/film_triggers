require 'application_system_test_case'

class ManageTriggersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  def setup
    Warden.test_reset!
  end

  test 'manage movie triggers' do
    VCR.use_cassette 'manage_triggers' do
      login_as users(:one)

      Trigger.create!(user: users(:one), movie_id: 330459, label: 'contains bananas')
      Trigger.create!(user: users(:one), movie_id: 330459, label: 'loud noises')
      Trigger.create!(user: users(:two), movie_id: 330459, label: 'loud noises')

      visit movie_path(330459)

      assert_selector '.movie-trigger', text: 'contains bananas x 1'
      assert_selector '.movie-trigger', text: 'loud noises x 2'

      select 'violence', from: 'Trigger'
      click_button 'Add trigger'

      assert_selector '.movie-trigger', text: 'violence x 1'
    end
  end
end
