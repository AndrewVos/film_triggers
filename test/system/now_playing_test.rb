require 'application_system_test_case'

class NowPlayingTest < ApplicationSystemTestCase
  test 'front page shows now playing movies' do
    VCR.use_cassette 'now_playing' do
      visit root_path

      assert_selector '.now-playing h3'
    end
  end
end
