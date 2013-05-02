class AddMatchTypToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :matchtyp, :string
  end
end
