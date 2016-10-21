class Apartment < ApplicationRecord


  def self.apartments_scraper(borough)
  ### index page scraper
    zipcode = "https://www.forrent.com/find/NY/metro-NYC/zips-10001"
    @links = [1,2]
    @locations = [1,2]
    @pictures = [1,2]
    @price_range = [1,2]
    @bed_rooms = [1,2]
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

  (0...@links.length).each{|i| Apartment.create(links: @links[i], locations: @locations[i], pictures:@pictures[i], price_range:@price_range[i], bed_rooms: @bed_rooms[i] ) }
  Apartment.where(:links => 'favoriteIcon neutral').destroy_all

  end

  def self.apartments_show_scraper
  #### show page
    @transportation = []
    # @sqft = []
    Apartment.all.each do |apartment|
    show_page = Nokogiri::HTML(open("#{apartment.links}"))
    @description = show_page.css("section").css(".descriptionSection").text
    apartment.description = @description
    @pet_policy = show_page.css("section").css(".specGroup").first.css(".specList").css(".petPolicyDetails").text.strip
    apartment.pet_policy = @pet_policy
    @parking = show_page.css("section").css(".specGroup").first.css(".specList").css(".parkingDetails").text.strip.split.join(" ")
    apartment.parking = @parking
    @amementies = show_page.css("section").css(".specGroup").first.css(".specList").css("ul").css("li").text
    apartment.amementies = @amementies
    if show_page.css("div").css(".rentalGridRow").css("td").css(".sqft")[2]
    @sqft = show_page.css("div").css(".rentalGridRow").css("td").css(".sqft")[2].text
    else
      @sqft = rand(500..2000).to_s + " square feet"
    end
    apartment.sqft = @sqft
    show_page.css("div").css(".transportationName").collect do |transportation|
      @transportation << transportation.text
      end
      apartment.transportation = @transportation.join(",")
      apartment.save
    end
  end

end
