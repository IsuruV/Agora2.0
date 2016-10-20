class CreateEbays < ActiveRecord::Migration[5.0]
  def change
    create_table :ebays do |t|

      t.timestamps
    end
  end
end
