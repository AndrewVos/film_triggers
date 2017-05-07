class MoviesController < ApplicationController
  def index
    @results = results(params[:q])
  end

  def show
    @movie = movie(params[:id])
    @triggers = Trigger
      .select('label, COUNT(label) AS count')
      .group(:label)
      .where(movie_id: params[:id])
  end

  private

  def movie(id)
    HTTParty.get(
      "https://api.themoviedb.org/3/movie/#{id}",
      query: {
        api_key: ENV.fetch('THE_MOVIE_DB_API_KEY')
      }
    ).parsed_response.with_indifferent_access
  end

  def results(query)
    if query.present?
      response = HTTParty.get(
        'https://api.themoviedb.org/3/search/movie',
        query: {
          api_key: ENV.fetch('THE_MOVIE_DB_API_KEY'),
          query: params[:q]
        }
      )
      response['results'].map(&:with_indifferent_access)
    else
      []
    end
  end
end