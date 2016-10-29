require 'pry'
require 'nokogiri'
require 'open-uri'

class Apartment < ApplicationRecord
 has_many :apartment_lists
 has_many :lists, :through => :apartment_lists
 has_many :users, :through => :lists
 has_many :tours

 scope :most_popular, -> { joins(:lists).group(:apartment_id).having("COUNT(*)").order('id DESC').limit(3) }

 # accepts_nested_attributes_for :lists

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

end
