require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/development.sqlite3"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'app'

def continue
  puts "What do you want to do next?\n1. Add a new movie\n2. Find existing movies\n3. Exit from the app"
  input = gets.chomp.to_i
  
  if input == 1
    add_new_movie
  elsif input == 2
    find_movies
  elsif input == 3
    puts "Thank you for using MyMovieList. Bye!"
  else
    invalid_input
  end
    
end
  
def invalid_input
  puts "Invalid input."
  continue
end
  

# def movie_exist?(input)
#   Movie.all.map(&:title).include? input
# end

def add_new_movie
  puts "What is the title of the movie?"
  movie_title = gets.chomp

  # if movie_exist?(movie_title)
  if Movie.find_by(title: movie_title)
    puts "#{movie_title} is already in the list."
    continue
  else
  
    puts "Who is the director?"
    director_name = gets.chomp
    new_director = Director.find_or_create_by(name: director_name)
    
    puts "Which studio?"
    studio_name = gets.chomp
    # new_studio = Studio.find_studio_by_name_or_create_new(studio_name)
    new_studio = Studio.find_or_create_by(name: studio_name)
    
    puts "How do you rate the movie? 1-5?"
    rating = gets.chomp.to_i
    
    Movie.create(title: movie_title, director: new_director, studio: new_studio, rating: rating)
    puts "#{movie_title} is added to your list."
    continue
  end
end
  

def find_movies_by_title
  puts "What is the title of the movie?"
  input = gets.chomp
  found_movie = Movie.all.find { |movie| movie.title == input }
  
  if found_movie
    puts "Title: #{found_movie.title}\nDirector: #{found_movie.director.name}\nStudio: #{found_movie.studio.name}\nRating: #{found_movie.rating}"
    continue
  else
    puts "There is no movie with the title #{input}."
    continue
  end

end
  
def find_movies_by_director
  puts "What is the name of the director?"
  input = gets.chomp
  found_director = Director.all.find { |director| director.name == input }
  
  if found_director
    found_director.movies.each_with_index do |movie, index|
      puts "#{index + 1} Title: #{movie.title} | Studio: #{movie.studio.name} | Rating: #{movie.rating}"
    end
    puts "The average rating of this director is #{found_director.average_rating}"
    continue
  else
    puts "There is no movie with the director name #{input}."
    continue
  end
  
end

def find_movies_by_studio
  puts "What is the name of the studio?"
  input = gets.chomp
  found_studio = Studio.all.find { |studio| studio.name == input }
  
  if found_studio
    found_studio.movies.each_with_index do |movie, index|
      puts "#{index + 1} Title: #{movie.title} | Director: #{movie.director.name} | Rating: #{movie.rating}"
    end
    puts "The average rating of this studio is #{found_studio.average_rating}"
    continue
  else
    puts "There is no movie with the studio name #{input}."
    continue
  end
end

def find_movies_by_rating
  puts "What is the rating do you want to lookup?"
  input = gets.chomp.to_i
  rated_movies = Movie.all.select { |movie| movie.rating == input }
  
  if rated_movies.count > 0
    rated_movies.each_with_index do |movie, index|
      puts "#{index + 1} Title: #{movie.title} | Director: #{movie.director.name} | Studio: #{movie.studio.name}"
    end
    continue
  else
    puts "There is no movie with the rating #{input}."
    continue
  end
    
end
  
def show_all_movies
  if Movie.all.count > 0
    Movie.all.each_with_index do |movie, index|
      puts "#{index + 1} Title: #{movie.title} | Director: #{movie.director.name} | Studio: #{movie.studio.name} | Rating: #{movie.rating}"
    end
  else
    puts "There is no movie in the list yet."
  end
  continue
end

def find_movies
  puts "How do you want to look up the movie?\n1. By title\n2. By director\n3. By studio\n4. By rating\n5. Show all the movies in the list"
  input = gets.chomp.to_i
  
  if input == 1
    find_movies_by_title
  elsif input == 2
    find_movies_by_director
  elsif input == 3
    find_movies_by_studio
  elsif input == 4
    find_movies_by_rating
  elsif input == 5
    show_all_movies
  else
    invalid_input
  end

end
  
def run
  puts "Welcome to MyMovieList! What do you want to do?\nEnter the number.\n1. Add a new movie\n2. Find existing movies"
  input = gets.chomp.to_i
  
  if input == 1
    add_new_movie
  elsif input == 2
    find_movies
  else
    invalid_input
  end
  
end

run