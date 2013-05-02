class CreateChambers < ActiveRecord::Migration
  def change
    create_table :chambers do |t|
      t.string :name
      t.string :photo_medium
      t.string :photo_small

      t.timestamps
    end
  end
end
