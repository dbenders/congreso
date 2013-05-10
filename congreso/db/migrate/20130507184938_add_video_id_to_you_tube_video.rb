class AddVideoIdToYouTubeVideo < ActiveRecord::Migration
  def change
    add_column :you_tube_videos, :video_id, :string
  end
end
