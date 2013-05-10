class TextBookmark < ActiveRecord::Base
  attr_accessible :length, :pos, :typ, :title
  belongs_to :person
  belongs_to :session
  has_one :bookmark

  def text
  	#if !title.nil?
  	#	title
  	#elsif session
  		session.transcript[pos..pos+length]
    #else 
    #  nil
  	#end
  end

  def matched?
    bookmark and bookmark.matchtyp == 'manual'
  end

  def to_s
    "#{pos}: #{person || ''}"
  end
end
