class CreateApartmentUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :apartment_users do |t|

      t.timestamps
    end
  end
end
