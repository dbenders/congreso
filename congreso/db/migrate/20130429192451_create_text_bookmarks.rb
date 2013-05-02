class CreateTextBookmarks < ActiveRecord::Migration
  def change
    create_table :text_bookmarks do |t|
      t.integer :pos
      t.integer :length

      t.timestamps
    end
  end
end
