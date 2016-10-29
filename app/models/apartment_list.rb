class ApartmentList < ApplicationRecord
  belongs_to :apartment
  belongs_to :list
  has_many :comments

end
