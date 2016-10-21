class CreateApartmentFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :apartment_features do |t|

      t.timestamps
    end
  end
end
