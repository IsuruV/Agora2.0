class ToursController < ApplicationController
  def new
    Tour.new
  end
  def create
    @tour = Tour.find_or_create_by(tour_params)
    flash[:error] = @tour.errors.messages
    redirect_to(:back)
  end

private
  def tour_params
    params.require(:tour).permit(
      :booked,
      :user_id,
      :apartment_id
    )
  end
end
