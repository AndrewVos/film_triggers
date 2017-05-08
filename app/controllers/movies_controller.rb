class MoviesController < ApplicationController
  def index
    @movies = search(params[:q])
    @now_playing = now_playing
  end

  def show
    @movie = movie(params[:id])
    @similar = similar(params[:id])
  end

  private

  def movie(id)
    Movie.new(
      TheMovieDb.get_cached("/movie/#{id}")
    )
  end

  def search(query)
    if query.present?
      response = TheMovieDb.get_cached('/search/movie', query: { query: params[:q] })
      response['results'].map do |result|
        Movie.new(result)
      end
    else
      []
    end
  end

  def now_playing
    response = TheMovieDb.get_cached('/movie/now_playing')
    response['results'].map do |result|
      Movie.new(result)
    end
  end

  def similar(id)
    response = TheMovieDb.get_cached("/movie/#{id}/similar")
    response['results'].map do |result|
      Movie.new(result)
    end
  end
end
