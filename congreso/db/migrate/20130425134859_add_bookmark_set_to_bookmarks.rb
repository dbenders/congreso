class AddBookmarkSetToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :bookmark_set_id, :integer
  end
end
