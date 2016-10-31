class Comment < ApplicationRecord
  belongs_to :apartment_list
  validates :text, :presence => true
end
