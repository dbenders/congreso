class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
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
