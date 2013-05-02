class Bookmark < ActiveRecord::Base
  attr_accessible :typ, :pos, :length, :textpos, :textlength, :title, :score, :matchtyp
  belongs_to :text_bookmark
  belongs_to :session
end
