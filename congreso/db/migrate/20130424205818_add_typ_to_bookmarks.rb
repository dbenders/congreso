class AddTypToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :typ, :string
  end
end
