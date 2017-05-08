class MoviesController < ApplicationController
  def index
    @movies = search(params[:q])
    @now_playing = now_playing
  end

  def show
    @movie = movie(params[:id])
  end

  private

  def movie(id)
    Movie.new(
      HTTParty.get(
        "https://api.themoviedb.org/3/movie/#{id}",
        query: {
          api_key: ENV.fetch('THE_MOVIE_DB_API_KEY')
        }
      ).parsed_response.with_indifferent_access
    )
  end

  def search(query)
    if query.present?
      response = HTTParty.get(
        'https://api.themoviedb.org/3/search/movie',
        query: {
          api_key: ENV.fetch('THE_MOVIE_DB_API_KEY'),
          query: params[:q]
        }
      )
      response['results'].map do |result|
        Movie.new(result)
      end
    else
      []
    end
  end

  def now_playing
    response = HTTParty.get(
      'https://api.themoviedb.org/3/movie/now_playing',
      query: {
        api_key: ENV.fetch('THE_MOVIE_DB_API_KEY')
      }
    )
    response['results'].map do |result|
      Movie.new(result)
    end
  end
end
