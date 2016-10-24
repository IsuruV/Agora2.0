class CreateApartmentLists < ActiveRecord::Migration[5.0]
  def change
    create_table :apartment_lists do |t|
      t.integer :list_id
      t.integer :apartment_id

      t.timestamps
    end
  end
end
