require 'selenium-webdriver'
require 'phantomjs'
require 'watir'
require 'watir-webdriver'
require 'capybara/dsl'
require 'pry'
require 'open-uri'
require 'nokogiri'

# binding.pry
def apartments_scraper(borough)
### index page scraper
  zipcode = "https://www.forrent.com/find/NY/metro-NYC/zips-10001"
  @links = []
  @locations = []
  @pictures = []
  @price_range = []
  @bed_rooms = []
  page = Nokogiri::HTML(open("http://www.apartments.com/#{borough}-ny/"))
  listing = page.css("div#placardContainer").css("article")
  listing.collect do |list|
    @price_range << list.css("div").css(".apartmentRentRollupContainer").css("span").css(".altRentDisplay").text
    @bed_rooms << list.css("div").css(".apartmentRentRollupContainer").css("span").css(".unitLabel").text
    @pictures << list.css("div").css(".media").css("div").css(".item").first.values[1]

    list.css("a").collect do |items|
      @links << items.values[1]
      @locations << items.values[2]
    end
  end

end

def apartments_show_scraper(link)
#### show page
  @transportation = []
  @sqft = []
  show_page = Nokogiri::HTML(open("#{link}"))
  @description = show_page.css("section").css(".descriptionSection").text
  @pet_policy = show_page.css("section").css(".specGroup").first.css(".specList").css(".petPolicyDetails").text.strip
  @parking = show_page.css("section").css(".specGroup").first.css(".specList").css(".parkingDetails").text.strip.split.join(" ")
  @amementies = show_page.css("section").css(".specGroup").first.css(".specList").css("ul").css("li").text.split("•")
  @sqft = page.css("div").css(".rentalGridRow").css("td").css(".sqft")[2].text
  show_page.css("div").css(".transportationName").collect do |transportation|
    @transportation << transportation.text
  end

end

####