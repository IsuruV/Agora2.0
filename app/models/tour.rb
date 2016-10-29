class Tour < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  validates :booked, :presence => true
  validate :correct_date?

  def correct_date?
    if booked.present? && booked < Date.today
       errors.add(:booked, "Must be a valid date")
    end
  end
end
