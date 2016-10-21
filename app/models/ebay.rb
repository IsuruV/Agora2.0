require 'pry'
require 'nokogiri'
require 'open-uri'
require 'capybara'
require 'capybara/poltergeist'
require 'watir-webdriver'

# class Ebay < ApplicationRecord
#
#
#   def scraper(input)
#
#     page = Nokogiri::HTML(open("http://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313.TR12.TRC2.A0.H0.Xprinter.TRS0&_nkw=#{input}&_sacat=0"))
#     front_page = page.css("div#Results").css("ul#ListViewInner").css("li")
#
#   end
#
# end

  def scraper(input)
      @show_page_link = []
      @image_link = []
      @product_name = []
      @product_price = []
      @listing_price = []

      page = Nokogiri::HTML(open("http://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313.TR12.TRC2.A0.H0.Xprinter.TRS0&_nkw=#{input}&_sacat=0"))
      front_page = page.css("div#Results").css("ul#ListViewInner").css("li")
      listing = front_page.css("li")

      listing.css("div").css(".lvpicinner").css("a").collect do |x|
        @show_page_link << x.values.first
      end

      listing.css("div").css(".lvpicinner").css("img").collect do |x|
        @image_link << x.values.first
      end

      listing.css("h3").collect do |title|
        @product_name << title.text
      end

      listing.css("li").css(".lvprice").collect do |price|
        @product_price << price.css("span").css(".bold").text
      end

      listing.css("li").css(".lvprice").collect do |price|
        @listing_price << price.css("span").css(".stk-thr").text
      end

      # def show_page_scraper(link)
      #   @reviews = []
      #   show_page = Nokogiri::HTML(open("#{link}"))
      #
      #   show_page.css("div").css(".reviews").
      # end
end
