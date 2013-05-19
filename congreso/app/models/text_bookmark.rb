class TextBookmark < ActiveRecord::Base
  attr_accessible :length, :pos, :typ, :title, :tags
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

  def section
    t = session.text_bookmarks.where("pos < #{pos} and typ = 'section'").order("pos")[-1].text
    t.sub(/- *\d+ *-/,'')
  end

  def matched?
    bookmark and bookmark.matchtyp == 'manual'
  end

  def candidate_tags
    t = text
    ans = []

    ans << 'argument' if t.include?("hablan a la vez")
    if person    
      last = person.lastname.downcase
      ans << 'interruption' if t.scan(/Sr\.([^(]+)\.-/).select { |p| 
        pp = p[0].strip.downcase
        !pp.include?("presindent") && !pp.include?(last)
      }.length > 0
    end
    ans.join(',')
  end

  def to_s
    "#{pos}: #{person || ''}"
  end
end
