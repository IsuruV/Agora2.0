require 'pry'

class ApartmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:home_page, :list, :index]

  def index

    # @first = Apartment.naked_apartments_scraper(params[:location])
    # @second =  Apartment.apartments_scraper(params[:location])
    # @search = @first + @second
    # @search = @first + @second
    # @search = Apartment.all.where("locations = %#{params[:apartments][:locations]}%")
    Apartment.naked_apartments_scraper(params[:location])
    Apartment.apartments_scraper(params[:location])

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
