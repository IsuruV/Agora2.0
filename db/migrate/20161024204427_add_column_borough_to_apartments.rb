class AddColumnBoroughToApartments < ActiveRecord::Migration[5.0]
  def change
    add_column :apartments, :borough, :string
  end
end
