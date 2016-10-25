class CreateApartment < ActiveRecord::Migration[5.0]
  def change
    create_table :apartments do |t|
      t.string :links
      t.string :locations
      t.string :pictures
      t.string :price_range
      t.string :bed_rooms
      t.string :transportation
      t.string :sqft
      t.string :description
      t.string :pet_policy
      t.string :parking
      t.string :amementies
    end
  end
end
