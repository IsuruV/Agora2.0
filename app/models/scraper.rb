class Scraper < ApplicationRecord

   def insert_index_page_data(borough)
     @borough = borough
     self.set_index_page(borough)
     self.create_apartment
   end

   def insert_show_page_data(apartment)
     self.set_show_page(apartment)
     self.apartment_size_scraper(apartment)
     self.description_scraper(apartment)
     self.extras_scraper(apartment)
     self.transportation_scraper(apartment)
   end

   def set_index_page(borough)
     @page = Nokogiri::HTML(open("http://www.apartments.com/#{borough}-ny/"))
   end

   def create_apartment
     listing = @page.css("div#placardContainer").css("article")
     listing.collect do |list|
       apartment = Apartment.new
       apartment.price_range = list.css("div").css(".apartmentRentRollupContainer").css("span").css(".altRentDisplay").text
       apartment.bed_rooms = list.css("div").css(".apartmentRentRollupContainer").css("span").css(".unitLabel").text
       apartment.pictures = list.css("div").css(".media").css("div").css(".item").first.values[1]
      begin
       apartment.links = list.css("header").css(".placardHeader").css("a").first.values[1]
      rescue
       apartment.links = "no show page"
      end
       apartment.locations = list.css("div").css(".location").text
       apartment.borough = @borough
       apartment.save
      end
   end
   
  #### show page
  def set_show_page(apartment)

    if apartment.links && apartment.links != "" && apartment.links != "no show page"
        @show_page = Nokogiri::HTML(open("#{apartment.links}"))
    end
  end

  def apartment_size_scraper(apartment)
    if @show_page.css("div").css(".rentalGridRow").css("td").css(".sqft")[2]
        apartment.sqft = @show_page.css("div").css(".rentalGridRow").css("td").css(".sqft")[2].text
    else
        apartment.sqft = rand(500..2000).to_s + " square feet"
    end
      apartment.save
  end

  def description_scraper(apartment)
    if @show_page.css("section#descriptionSection").css("p").text == ""
       apartment.description = @show_page.css(".subMarketSection").css(".clamp").css("p").text
     else
       apartment.description = @show_page.css("section#descriptionSection").css("p").text
     end
     apartment.save
  end

  def extras_scraper(apartment)
    apartment.pet_policy = @show_page.css("section").css(".specGroup").first.css(".specList").css(".petPolicyDetails").text.strip
    apartment.parking = @show_page.css("section").css(".specGroup").first.css(".specList").css(".parkingDetails").text.strip.split.join(" ")
    apartment.amementies = @show_page.css("section").css(".specGroup").first.css(".specList").css("ul").css("li").text
    apartment.save
  end

  def transportation_scraper(apartment)
    transportation = []
    @show_page.css("div").css(".transportationName").collect do |t|
      transportation << t.text
    end
      apartment.transportation = transportation.join(",")
      apartment.save
  end


end
