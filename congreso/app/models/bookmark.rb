class Bookmark < ActiveRecord::Base
  attr_accessible :typ, :pos, :length, :textpos, :textlength
  belongs_to :bookmark_set
  belongs_to :person
end
