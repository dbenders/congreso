class Session < ActiveRecord::Base
  include SessionsHelper

  attr_accessible :date, :name, :transcript, :video_url, :length, :period, :meeting
  has_many :text_bookmarks, :order => "pos ASC"
  has_many :bookmarks, :order => "pos ASC"
  belongs_to :chamber

  def transcript=(text)
    self[:transcript] = text.gsub(/\r/,"")
  end

  def transcript_section_segments
    transcript_segments.select {|segm| segm[:type] == :section}
  end

  def transcript_segments
    ans = []    
    pos = 0
    curr_section = nil
    section = 0

    transcript.split("\n").each do |line|

      if line =~ /^Sr/
        if not ans.empty? and not ans[-1][:end]
          ans[-1][:end] = pos -1
        end

        ans << {:type => :speech, :speaker => line.scan(/Sra?\. (.*?)\.-/)[0][0],
              :begin => pos + (line =~ /\.-/) + 2}        
      elsif line =~ /^- \d+ -/
        if not ans.empty? and not ans[-1][:end]
          ans[-1][:end] = pos -1
        end
        if curr_section
          curr_section[:end] = pos
          curr_section[:name] = transcript[curr_section[:begin]..curr_section[:end]].scan(/\n(.*)\n/)[0][0].strip 
        end
        curr_section = {:type => :section, :number => line.scan(/\d+/)[0].to_i, :begin => pos}
        ans << curr_section
      elsif line =~ /^-/ or line == line.upcase
        if not ans.empty? and not ans[-1][:end]
          ans[-1][:end] = pos -1
        end
      end
      pos += line.length + 1
    end
    if not ans.empty? and not ans[-1][:end]
      ans[-1][:end] = pos -1
    end
    ans
  end

  def match_bookmarks

    bookmarks.each do |bk|
      if bk.matchtyp != 'manual'
        bk.matchtyp = nil
        bk.save!
        if bk.text_bookmark
          bk.text_bookmark.bookmark = nil
          bk.text_bookmark.save!
        end
      end
    end

    tbks = text_bookmarks.select {|tbk| !tbk.person.nil?}
    bks = bookmarks.all
    i0 = nil
    tbks.each_with_index do |tbk,i|
      if tbk.bookmark and tbk.bookmark.matchtyp == 'manual'
        if !i0.nil?      
          j0 = bks.index(tbks[i0].bookmark)
          j = bks.index(tbks[i].bookmark)
          match(tbks[i0..i],bks[j0..j])
        end
        i0 = i
      end
    end
    bks.each { |bk| bk.save! }
    tbks.each { |tbk| tbk.save! }
  end



  def rebuild_text_bookmarks
    ans = []    
    pos = 0
    curr_section = nil
    section = 0
    not_found = Set.new
    text_bookmarks.clear
    transcript_segments.each do |segm|
      b = TextBookmark.new({:typ => segm[:type], :pos => segm[:begin], :length => segm[:end] - segm[:begin]})
      b.session = self
      if b.typ == :section
        b.title = segm[:name]
      elsif b.typ == :speech
        if !not_found.include?(segm[:speaker])
          b.person = Person.find_by_short_name(segm[:speaker])
          if b.person.nil?
            not_found << segm[:speaker]
          end
        end
      end
      b.save!
    end
  end  
end
