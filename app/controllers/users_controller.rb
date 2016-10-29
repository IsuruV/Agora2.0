class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    if params[:location]
        if params[:location] == "New York"
        @location = "manhattan"
      else
        @location = params[:location]
      end
   end

  end

  def show
    sign_out(current_user)
    flash[:message] = "You are logged off"
    redirect_to root_path
  end

  def create

  end

  def location

  end

  def tours
    @tours = current_user.tours
  end

end
