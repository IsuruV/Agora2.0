class Scraper < ApplicationRecord
  def self.apartments_scraper(borough)
  ### index page scraper
      zipcode = "https://www.forrent.com/find/NY/metro-NYC/zips-10001"
      @show_page_link = []
      @location = []
      @picture = []
      @price_range = []
      @bed_rooms = []
      page = Nokogiri::HTML(open("http://www.apartments.com/#{borough}-ny/"))
      listing = page.css("div#placardContainer").css("article")
      listing.collect do |list|
        @price_range << list.css("div").css(".apartmentRentRollupContainer").css("span").css(".altRentDisplay").text
        @bed_rooms << list.css("div").css(".apartmentRentRollupContainer").css("span").css(".unitLabel").text
        @picture << list.css("div").css(".media").css("div").css(".item").first.values[1]
          begin
          @show_page_link << list.css("header").css(".placardHeader").css("a").first.values[1]
          rescue
            @show_page_link << "no show page"
          end
          @location << list.css("div").css(".location").text
    end
    (0...@show_page_link.count).collect{|i| Apartment.find_or_create_by(links: @show_page_link[i], locations: @location[i], pictures:@picture[i], price_range:@price_range[i], bed_rooms: @bed_rooms[i], borough:borough ) }
      Apartment.all.where(borough: borough).each do |apartment|
        if apartment.links && apartment.links != "" && apartment.links != "no show page"
          Scraper.apartments_show_scraper(apartment)
        end
    end
  end
  def self.apartments_show_scraper(apartment)
  #### show page
    @transportation = []
    if apartment.links && apartment.links != "" && apartment.links != "no show page"
      show_page = Nokogiri::HTML(open("#{apartment.links}"))
      if show_page.css("section#descriptionSection").css("p").text == ""
         @description = show_page.css(".subMarketSection").css(".clamp").css("p").text
       else
         @description = show_page.css("section#descriptionSection").css("p").text
       end
       apartment.description = @description
      begin
        @pet_policy = show_page.css("section").css(".specGroup").first.css(".specList").css(".petPolicyDetails").text.strip
      rescue
        @pet_policy = "No policy"
      end
      apartment.pet_policy = @pet_policy
      begin
        @parking = show_page.css("section").css(".specGroup").first.css(".specList").css(".parkingDetails").text.strip.split.join(" ")
      rescue
        @parking = "Not available"
      end
      apartment.parking = @parking
      begin
      @amementies = show_page.css("section").css(".specGroup").first.css(".specList").css("ul").css("li").text
      rescue
        @amementies = "Not available"
      end
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
######
#   def apartment.naked_apartments_scraper(borough)
#       manhattan = 'http://www.nakedapartments.com/renter/listings/search?nids=23%2C211%2C6%2C21%2C203%2C191%2C194%2C18%2C24%2C76%2C204%2C205%2C10%2C14%2C195%2C1%2C5%2C25%2C93%2C206%2C22%2C17%2C207%2C13%2C155%2C16%2C72%2C2%2C9%2C20%2C19%2C73%2C7%2C208%2C209%2C192%2C8%2C74%2C210%2C11%2C4%2C3%2C26%2C212%2C12&order=asc&page=1&sort=rent'
#        brooklyn = 'http://www.nakedapartments.com/renter/listings/search?nids=117%2C77%2C46%2C29%2C78%2C36%2C79%2C118%2C30%2C119%2C41%2C120%2C37%2C31%2C38%2C213%2C121%2C45%2C122%2C32%2C33%2C123%2C124%2C82%2C83%2C84%2C34%2C214%2C39%2C126%2C43%2C127%2C85%2C215%2C216%2C129%2C95%2C130%2C27%2C28%2C128%2C88%2C40%2C217%2C132%2C89%2C35%2C44%2C47&order=asc&page=1&sort=rent'
#        queens = 'http://www.nakedapartments.com/renter/listings/search?nids=48%2C220%2C99%2C235%2C108%2C137%2C102%2C222%2C221%2C107%2C148%2C98%2C96%2C49%2C149%2C101%2C139%2C100%2C112%2C54%2C55%2C224%2C190%2C236%2C141%2C223%2C218%2C237%2C197%2C53%2C105%2C201%2C226%2C136%2C97%2C227%2C228%2C50%2C113%2C114%2C159%2C229%2C230%2C219%2C110%2C144%2C106%2C157%2C91%2C104%2C115%2C231%2C146%2C109%2C232%2C111%2C116%2C233%2C51%2C234%2C196%2C103%2C52&order=asc&page=1&sort=rent'
#        staten_island = 'http://www.nakedapartments.com/renter/listings/search?nids=277%2C278%2C67%2C279%2C280%2C71%2C281%2C283%2C284%2C285%2C286%2C288%2C289%2C68%2C290%2C291%2C292%2C282%2C287%2C293%2C294%2C295%2C296%2C297%2C298%2C299%2C300%2C301%2C302%2C303%2C304%2C305%2C306%2C307%2C145%2C308%2C309%2C69%2C310%2C311%2C312%2C313%2C70%2C314%2C315%2C316%2C317&order=asc&page=1&sort=rent'
#
#     if borough == "manhattan"
#        @b = manhattan
#      elsif borough == "bronx"
#        @b = bronx
#      elsif borough == "brooklyn"
#        @b = brooklyn
#      elsif borough == "queens"
#        @b = queens
#      else
#        @b = staten_island
#      end
#
#     page = Nokogiri::HTML(open(@b))
#
#     @street_address = []
#
#     @pictures = []
#     @show_page_links = []
#     @bedrooms = []
#     @bathrooms = []
#
#
#     @features = []
#     @prices = []
#
#
#
#     page.css("span").css(".listing-address").each do |address|
#       @street_address << address.text
#     end
#
#     page.css("div").css(".listing-title").each do |link|
#       @show_page_links << link.attribute("href").value
#     end
#
#     page.css("div").css(".listing-image").each do |picture|
#        if picture.children[1].children.first.attributes['data-original'] != nil
#          @pictures << picture.children[1].children.first.attributes['data-original'].value
#        end
#      end
#     page.css("div").css(".listing-results")
#
#
#     page.css("span").css(".listing-size").each do |bedroom|
#       @bedrooms << bedroom.children.text.split("BR")[0]
#     end
#
#     page.css("span").css(".listing-size").each do |bathroom|
#
#       if bathroom.children.text.split("BR")[0] == "STUDIO"
#         @bathrooms << "1"
#       else
#         begin
#         @bathrooms << bathroom.children.text.split(" ")[1].split("B")[0]
#       rescue
#         @bathrooms << "1"
#       end
#       end
#     end
#
#   (0...@show_page_links.length).each{|i| Apartment.find_or_create_by(links: @show_page_links[i], locations: @street_address[i], pictures:@pictures[i], bed_rooms: @bedrooms[i], borough:borough ) }
#
#
#   Apartment.all.where(borough: borough).each do |apartment|
#     if @show_page_links.include?(apartment.links)
#
#       show_page = Nokogiri::HTML(open("#{apartment.links}"))
#
#       @description = show_page.css("div#neighborhood-pane").css("p").text
#       apartment.description = @description
#       @transportation = []
#       show_page.css("div").css(".transportation").css("span").collect do |a|
#           @transportation << a.text
#         end
#         apartment.transportation = @transportation.uniq.collect{|a|a.strip}.join(" ,")
#       begin
#       @features = show_page.css("div").css(".text")[1].text
#       rescue
#         @features = " "
#       end
#       apartment.amementies = @features
#         @price = show_page.css("span").css(".price").text
#         apartment.price_range = @price
#         apartment.save
#       end
#     end
#
#   end
end
