require 'pry'
require 'nokogiri'
require 'open-uri'

class Apartment < ApplicationRecord
 has_many :apartment_lists
 has_many :lists, :through => :apartment_lists
 has_many :users, :through => :lists
 has_many :tours
 has_many :comments, :through => :apartment_lists
 accepts_nested_attributes_for :comments
 scope :most_popular, -> { joins(:lists).group(:apartment_id).having("COUNT(*)").order('id DESC').limit(3) }
 scope :lowest_highest, -> {order('price_range ASC')}

 def lists_attributes=(attr)
  #  {"0"=>{name: ""}}
  #  binding.pry
    attr.values.each do |list|
      if list[:name].present?
        @list = List.find_or_create_by(name:list['name'])
        @list.user_id = list['user_id']
        self.lists << @list
      end
    end
  end

  def comments_attributes=(attr)
   attr.values.each do |comment|
     if comment[:text].present?
       @comment =  Comment.create(text: comment[:text])
       list_ids.each do |list|
         @apartment_list = ApartmentList.find_by(list_id: list, apartment_id: self.id)
         if @apartment_list
           @apartment_list.comments.create(text: comment[:text])
           @apartment_list.save
         end
       end
     end
   end
 end

end
