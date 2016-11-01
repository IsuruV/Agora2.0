# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 @manhattan = Scraper.new
 @manhattan.insert_index_page_data("manhattan")

 @queens = Scraper.new
 @queens.insert_apt("queens")

 @brooklyn = Scraper.new
 @brooklyn.insert_apt("brooklyn")

 @show_page_scraper = Scraper.new

 Apartment.all.each do |apartment|
   @show_page_scraper.insert_show_page_data(apartment)
 end
