module MoviesHelper
  def poster_url_for(poster_path)
    return 'http://placehold.it/92x138' unless poster_path.present?
    "https://image.tmdb.org/t/p/w92#{poster_path}"
  end

  def large_poster_url_for(poster_path)
    return 'http://placehold.it/300x450' unless poster_path.present?
    "https://image.tmdb.org/t/p/w300#{poster_path}"
  end
end
