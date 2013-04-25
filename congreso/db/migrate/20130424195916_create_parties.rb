class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :photo_small
      t.string :photo_medium
      t.string :wikipedia
      t.string :facebook
      t.string :twitter
      t.string :website

      t.timestamps
    end
  end
end
