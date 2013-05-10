class CreateYouTubeVideos < ActiveRecord::Migration
  def change
    create_table :you_tube_videos do |t|
      t.string :id
      t.string :name
      t.integer :num
      t.integer :session_id

      t.timestamps
    end
  end
end
