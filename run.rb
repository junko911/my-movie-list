require 'pry'
require_relative './app/models/director'
require_relative './app/models/movie'
require_relative './app/models/studio'

def run
  puts "Welcome to MyMovieList! What do you want to do?\nEnter the number\n1. Add a new movie\n2. Find existing movies"
  input1 = gets.chomp

  if input1.to_i == 1
    puts "What is the name of the movie?"
    movie_title = gets.chomp
    puts "Who is the director?"
    director_name = gets.chomp
    new_director = Director.find_director_by_name_or_create_new(director_name)
    puts "Which studio?"
    studio_name = gets.chomp
    new_studio = Studio.find_studio_by_name_or_create_new(studio_name)
    puts "How do you rate the movie? 1-5?"
    rating = gets.chomp
    Movie.new(movie_title, new_director, new_studio, rating.to_i)
    puts "#{movie_title} is added to your list. Do you want continue?\n1. Continue 2. Exit from the app"
    input2 = gets.chomp

    if input2.to_i == 1
      run
    else
      puts "Bye!"
    end

  elsif input1.to_i == 2
    puts "How do you want to look up the movie?\n1. By title\n2. By director\n3. By studio"
    input3 = gets.chomp

    if input3.to_i == 1
      puts "What is the title of the movie?"
      input4 = gets.chomp
      found_movie = Movie.all.find { |movie| movie.title == input4 }
      
      if found_movie
        puts "Title: #{found_movie.title}\nDirector: #{found_movie.director.name}\nStudio: #{found_movie.studio.name}\nRating: #{found_movie.rating}\nDo you want continue?\n1. Continue 2. Exit from the app"
        input5 = gets.chomp
        
        if input5.to_i == 1
          run
        else
          puts "Bye!"
        end
        
      else
        puts "There is no movie with that title. Try again."
        run
      end

    elsif input3.to_i == 2
      puts "What is the name of the director?"
      input6 = gets.chomp
      # binding.pry
      found_director = Director.all.find { |director| director.name == input6 }
      found_director.movies.each_with_index do |movie, index|
        puts "#{index + 1} Title: #{movie.title} Studio: #{movie.studio.name} Rating: #{movie.rating}"
      end
      puts "The average rating of this director is #{found_director.average_rating}"
      puts "Do you want continue?\n1. Continue 2. Exit from the app"
      input7 = gets.chomp
        
      if input7.to_i == 1
        run
      else
        puts "Bye!"
      end
    
    elsif input3.to_i == 3
      puts "What is the name of the studio?"
      input7 = gets.chomp
      found_studio = Studio.all.find { |studio| studio.name == input7 }
      found_studio.movies.each_with_index do |movie, index|
      puts "#{index + 1} Title: #{movie.title} Director: #{movie.director.name} Rating: #{movie.rating}"
      end
      puts "Do you want continue?\n1. Continue 2. Exit from the app"
      input8 = gets.chomp
        
      if input8.to_i == 1
        run
      else
        puts "Bye!"
      end
    end

  else
    puts "Invalid input. Bye!"
  end

end

run