class AddFieldsToTextBookmark < ActiveRecord::Migration
  def change
    add_column :text_bookmarks, :typ, :string
    add_column :text_bookmarks, :title, :string
  end
end
