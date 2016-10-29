class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :apartment_list_id
      t.string :text
    end
  end
end
