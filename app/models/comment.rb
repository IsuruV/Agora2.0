class Comment < ApplicationRecord
  belongs_to :apartment_list
  validates :text, :presence => true

  def pres?
    if booked.present? && booked < Date.today
       errors.add(:booked, "Must be a valid date")
    end
  end

end
