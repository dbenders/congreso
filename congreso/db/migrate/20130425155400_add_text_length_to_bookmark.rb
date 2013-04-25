class AddTextLengthToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :textlength, :integer
  end
end
