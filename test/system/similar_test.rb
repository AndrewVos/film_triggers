require 'application_system_test_case'

class SimilarTest < ApplicationSystemTestCase
  test 'similar movies' do
    VCR.use_cassette 'similar' do
      visit movie_path(330459)
      assert_selector '.similar h3'
    end
  end
end
