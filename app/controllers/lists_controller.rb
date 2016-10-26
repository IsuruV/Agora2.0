class ListsController < ApplicationController
  # before_filter :authenticate_user!
  before_action :authenticate_user!


  def new
    # binding.pry
    # if current_user.id == params[:user_id].to_i
    @user = current_user
    @list = @user.lists.new
  # else
  #   redirect_to root_path
  #   flash[:error] = "noope"
  # end
end

  def add_to_list

    @lists = []
    @apartment = Apartment.find(params[:apartment_id])
    params[:user][:lists].each do |list_id|
      if list_id != ""
        @lists << current_user.lists.find(list_id)
      end
    end
    @lists.each do |list|
      if !list.apartments.include?(@apartment)
        list.apartments << @apartment
      end
    end

    if params[:user][:list][:name]
      @current_list = current_user.lists.find_or_create_by(name:params[:user][:list][:name])
      @current_list.apartments << @apartment
    end

    flash[:message] = "Added to List"
      redirect_to(:back)
  end




  def index
    if params[:list_id]
      @current_list = current_user.lists.find_by_id(params[:list_id])

    else
        @current_list = current_user.lists.first
    end
  end

  def create

      @list = List.find_by(name:params[:list][:name])
      if @list
        flash[:message] = "List already exists"
      else
        current_user.lists.create(name:params[:list][:name])
      end
      redirect_to user_lists_path(current_user)
  end



  def show
  end

  def update
    # binding.pry
    @lists = []
    @apartment = Apartment.find(params[:apartment_id])
    params[:user][:lists].each do |list_id|
      if list_id != ""
        @lists << current_user.lists.find(list_id)
      end
    end
    @lists.each do |list|
      if !list.apartments.include?(@apartment)
        list.apartments << @apartment
      end
    end
    flash[:message] = "Added to List"
      redirect_to(:back)
  end

end
