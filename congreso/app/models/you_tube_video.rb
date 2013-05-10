class YouTubeVideo < ActiveRecord::Base
  attr_accessible :video_id, :name, :num, :length
  belongs_to :session
end
