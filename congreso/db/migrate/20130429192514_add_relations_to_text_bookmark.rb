class AddRelationsToTextBookmark < ActiveRecord::Migration
  def change
    add_column :text_bookmarks, :person_id, :integer
    add_column :text_bookmarks, :session_id, :integer
  end
end
