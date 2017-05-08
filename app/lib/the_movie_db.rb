class TheMovieDb
  include HTTParty

  base_uri 'https://api.themoviedb.org/3'
  default_params api_key: ENV.fetch('THE_MOVIE_DB_API_KEY')
end
