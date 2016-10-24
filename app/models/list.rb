class List < ApplicationRecord
  has_many :apartment_lists
  has_many :apartments, through: :apartment_lists
  belongs_to :user
end
