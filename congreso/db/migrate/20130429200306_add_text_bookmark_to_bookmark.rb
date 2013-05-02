class AddTextBookmarkToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :text_bookmark_id, :integer
  end
end
