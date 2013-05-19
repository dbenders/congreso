class AddTagsToTextBookmark < ActiveRecord::Migration
  def change
    add_column :text_bookmarks, :tags, :string
  end
end
