require 'pry'

class ApartmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:home_page, :list, :index]

  def new

  end

  def create

  end

  def index
    @ary = Apartment.where(borough:params[:location]).lowest_highest
  end

  def show
    @tour = Tour.new

    @apartment = Apartment.find_by_id(params[:id])
    @apartment.lists.build(user_id:current_user)
  end


  def update
    @apartment = Apartment.find_by_id(params[:id])

    @apartment.update(apartment_params)
    flash[:error] = @apartment.errors.messages
    flash[:message] = "Added to List"
    redirect_to(:back)

  end


 # private
  def apartment_params
    params.require(:apartment).permit(
      lists_attributes:[
        :name,
        :user_id
      ],
      commnet_attributes:[

      :text
    ],
      list_ids: []
    )
  end

end
