class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |a|
      a.string :links
      a.string :locations
      a.string :pictures
      a.string :price_range
      a.string :bed_rooms
      a.string :transportation
      a.string :sqft
      a.string :description
      a.string :pet_policy
      a.string :parking
      a.string :amementies
    end
  end
end
