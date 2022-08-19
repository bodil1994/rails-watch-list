# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Bookmark.delete_all
List.delete_all
Movie.delete_all

movies = RestClient.get "https://tmdb.lewagon.com/movie/top_rated"
movies = JSON.parse(movies)
movies = movies["results"] # array of hashes

movies.each do |movie|
  Movie.create(title: movie["original_title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}", rating: movie["vote_average"])
end

file = URI.open("https://source.unsplash.com/random?movie")

List.create(name: "Favorites")
List.first.photo.attach(io: file, filename: "list1.png", content_type: "png")
Bookmark.create!(comment: "love it", movie: Movie.first, list: List.first)
Bookmark.create!(comment: "funnylol", movie: Movie.all[8], list: List.first)
