require 'pry'

class Director
  attr_reader :name
  @@all = []

  def initialize(name)
    @name = name
    Director.all << self
  end

  def self.all
    @@all
  end

  def movies
    Movie.all.select { |movie| movie.director == self }
  end

  def studios
    movies.map(&:studio).uniq
  end

  def self.find_director_by_name_or_create_new(passed_name)
    found_director = all.find { |director| director.name == passed_name}
    if found_director
      found_director
    else
      Director.new(passed_name)
    end
  end

  def average_rating
    sum = 0
    sum_of_rating = movies.each { |movie| sum += movie.rating }
    avg = sum.to_f / movies.count.to_f
    avg.round(2)
  end
end

binding.pry