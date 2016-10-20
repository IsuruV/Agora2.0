class CreateAmazons < ActiveRecord::Migration[5.0]
  def change
    create_table :amazons do |t|

      t.timestamps
    end
  end
end
