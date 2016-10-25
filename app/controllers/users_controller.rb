class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    # @user = User.new
    if current_user
      current_user.creat_default_lists
    end
  end

  def show
    # binding.pry
    sign_out(current_user)
    redirect_to root_path
  end

  def create

  end


end
