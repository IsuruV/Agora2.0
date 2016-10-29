class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.datetime :booked
      t.integer :user_id
      t.integer :apartment_id

      t.timestamps
    end
  end
end
