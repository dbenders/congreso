class AddBookmarkIdToTextBookmark < ActiveRecord::Migration
  def change
    add_column :text_bookmarks, :bookmark_id, :integer
  end
end
