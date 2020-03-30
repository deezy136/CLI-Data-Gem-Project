require "movie_scraper/version"
require 'nokogiri'
require 'httparty'
require 'pry'

class Scraper
  URL = "https://www.amctheatres.com"
  MOVIES = Array.new



  def initialize
    get_all_movies
    list_movies
    pick_movie
  end


  def pick_movie 
    input = nil

    while input != "exit"
        puts "Select a movie number to see Duration and Rating or type exit"
        input = gets.strip.downcase
        if input.to_i > 0 
          p '----------------------------------------'
            puts MOVIES[input.to_i][:name]
            puts MOVIES[input.to_i][:duration]
            puts MOVIES[input.to_i][:pag]
            puts MOVIES[input.to_i][:url]
            p '-------------------------------------'
        elsif input == "list"
          list_movies 

          elsif input == "exit"
            puts "Thanks for Looking at the Movie Listings. Good Bye!"
        else 
          puts "Not sure what you want, type list or exit."
   end 
  end 
end 
   # elsif input == "list"
      #  list_deals
    #else
      #  puts "Not sure what you want, type list or exit."
   # end 
  #end 
    
      

  def list_movies
      MOVIES.each.with_index(1) do |movie, i|
      p "--------------------------------------------------------------------------------------"
     puts "#{i}. Name: #{movie[:name]}."
     end 
    end
  
 



  def get_all_movies
    unparsed_page = HTTParty.get(URL)
    parsed_page = Nokogiri::HTML(unparsed_page)
    movie_listings = parsed_page.css('div.Slide') #18 movies
    movie_listings.each do |movie_listing|
        movie = {
          name: movie_listing.css('a').text,
          duration: movie_listing.css('span.u-separator.js-runtimeConvert.u-inlineFlexCenter').text,
          pag:  movie_listing.css('span')[3].children.text,
          url: "https://www.amctheatres.com" + movie_listing.css('a')[0].attributes["href"].value
          #binding.pry
        }
       
         MOVIES << movie
        
    end 
    
   
  end
end 



