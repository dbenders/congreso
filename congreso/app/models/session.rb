class Session < ActiveRecord::Base
  attr_accessible :chamber, :date, :name, :transcript, :video_url
  has_many :bookmark_sets

  def transcript=(text)
    self[:transcript] = text.gsub(/\r/,"")
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
end
