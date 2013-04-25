class CreateBookmarkSets < ActiveRecord::Migration
  def change
    create_table :bookmark_sets do |t|
      t.string :typ
      t.string :name
      t.integer :session_id

      t.timestamps
    end
  end
end
