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

end