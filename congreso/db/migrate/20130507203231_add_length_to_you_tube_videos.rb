class AddLengthToYouTubeVideos < ActiveRecord::Migration
  def change
    add_column :you_tube_videos, :length, :integer
  end
end
