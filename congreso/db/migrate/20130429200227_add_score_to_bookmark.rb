class AddScoreToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :score, :float
  end
end
