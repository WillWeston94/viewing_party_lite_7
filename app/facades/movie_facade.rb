class MovieFacade
  def self.details(movie_id)
    movie_data = MovieDbService.new.movie_details(movie_id)
    Movie.new(movie_data)
  end

  def self.cast(movie_id)
    cast_data = MovieDbService.new.movie_cast(movie_id)
    cast_data.map { |cast_member| Cast.new(cast_member) }
  end

  def self.reviews(movie_id)
    review_data = MovieDbService.new.movie_reviews(movie_id)
    review_data[:results].map { |review| Review.new(review) }
  end
end