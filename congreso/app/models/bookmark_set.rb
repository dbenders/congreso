class BookmarkSet < ActiveRecord::Base
  attr_accessible :name, :typ
  belongs_to :session
  has_many :bookmarks

  def match_text
    return if bookmarks.empty?      
    segments = session.transcript_segments.select {|segm| segm[:type] == :speech}
    segments.each {|segm| segm[:person] = Person.find_by_short_name(segm[:speaker])}
    i = 0
    bookmarks.each do |b|
      while i<segments.length 
        if segments[i][:person] == b.person
          b.textpos = segments[i][:begin]
          b.textlength = segments[i][:end] - segments[i][:begin]
          b.save!
          puts "#{b.person} => #{segments[i]}"
          break
        end
        i += 1
      end
    end
  end

end
