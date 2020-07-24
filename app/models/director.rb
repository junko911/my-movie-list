class Director < ActiveRecord::Base
  has_many :movies
  has_many :studios, through: :movies

  # def self.find_director_by_name_or_create_new(passed_name)
  #   found_director = all.find { |director| director.name == passed_name}
  #   if found_director
  #     found_director
  #   else
  #     Director.new(passed_name)
  #   end
  # end

  def average_rating
    sum = 0
    sum_of_rating = movies.each { |movie| sum += movie.rating }
    avg = sum.to_f / movies.count.to_f
    avg.round(2)
  end
end