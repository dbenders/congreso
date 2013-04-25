class CreateVideoBookmarks < ActiveRecord::Migration
  def change
    create_table :video_bookmarks do |t|
      t.string :type
      t.integer :pos
      t.integer :session_id
      t.integer :person_id

      t.timestamps
    end
  end
end
