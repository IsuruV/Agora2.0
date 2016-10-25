require 'pry'

class ApartmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:home_page, :list, :index]

  def index

    # Apartment.apartments_scraper(params[:location])
    # Apartment.naked_apartments_scraper(params[:location])
    #put these two in a thread that runs every 5 minutes..

    @search = Apartment.where(borough:params[:location])

  end

  def show

    @apartment = Apartment.find_by_id(params[:id])
    # binding.pry
    @apartment.apartments_show_scraper
    # binding.pry
  end

  def home_page

  end



  # private
  # def apartment_params
  #   params.require(:apartment).permit(:title, :description)
  # end
end
