class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    # binding.pry
    if params[:location]
        if params[:location] == "New York"
        @location = "manhattan"
      else
        @location = params[:location]
      end
   end

    # @user = User.new
    # if current_user
    #   current_user.creat_default_lists
    # end
  end

  def show
    # binding.pry
    sign_out(current_user)
    flash[:message] = "You are logged off"
    redirect_to root_path
  end

  def create

  end

  def location
    # binding.pry
  end

end
