class ListsController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_user!

  def new
    # binding.pry
    if current_user.id == params[:user_id].to_i
    @user = current_user
    @list = @user.lists.new
  else
    redirect_to root_path
    flash[:error] = "noope"
  end

  end
    # @list = List.new

  def create
  binding.pry
  end

  def index
  end

  def show
  end

  def update
  end




end
