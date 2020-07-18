class Movie
  attr_reader :title, :director, :studio
  attr_accessor :rating
  @@all = []

  def initialize(title, director, studio, rating)
    @title = title
    @director = director
    @studio = studio
    @rating = rating
    Movie.all << self
  end

  def self.all
    @@all
  end

  # def self.find_movie_by_title(passed_title)
  #   found_movie = Movie.all.find { |movie| movie.title == passed_title }
  #   if found_movie
  #     puts "Title:#{found_movie.title}\nDirector:#{found_movie.director}\nStudio:#{found_movie.studio}\nRating:#{found_movie.rating}"
  #   else
  #     puts "There is no movie with that title. Try again."
  #   end
  # end
end