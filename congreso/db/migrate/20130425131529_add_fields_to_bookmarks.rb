class AddFieldsToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :textpos, :integer
    add_column :bookmarks, :testlength, :integer
    add_column :bookmarks, :length, :integer
  end
end
