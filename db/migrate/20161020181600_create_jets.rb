class CreateJets < ActiveRecord::Migration[5.0]
  def change
    create_table :jets do |t|

      t.timestamps
    end
  end
end
