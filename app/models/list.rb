class List < ApplicationRecord
  has_many :apartment_lists
  has_many :apartments, through: :apartment_lists
  accepts_nested_attributes_for :apartments
  belongs_to :user
  validates :name, :presence => true
end
