class Movie
  def initialize(options)
    @options = options

    options.each do |key, value|
      define_singleton_method key do
        value
      end
    end
  end

  def imdb_url
    "http://www.imdb.com/title/#{imdb_id}/"
  end

  def triggers
    @triggers ||= Trigger
      .select('label, COUNT(label) AS count')
      .group(:label)
      .where(movie_id: id)
  end

  def poster_url
    return 'http://placehold.it/92x138' unless poster_path.present?
    "https://image.tmdb.org/t/p/w92#{poster_path}"
  end

  def large_poster_url
    return 'http://placehold.it/300x450' unless poster_path.present?
    "https://image.tmdb.org/t/p/w300#{poster_path}"
  end

  def title_with_year
    if year
      "#{title} (#{year})"
    else
      title
    end
  end

  def year
    if release_date.present?
      Date.parse(release_date).year
    else
      nil
    end
  end
end
