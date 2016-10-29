class Tour < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  validates :booked, :presence => true
end
