class Session < ActiveRecord::Base
  attr_accessible :chamber, :date, :name, :transcript, :video_url
  has_many :bookmarks
end
