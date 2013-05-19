# encoding: UTF-8

class TextBookmarksController < ApplicationController

  # GET /diputados/131/1/text_bookmarks/1/transcript
  def transcript
    @text_bookmark = TextBookmark.find(params[:text_bookmark_id])
    transcript = @text_bookmark.text
    respond_to do |format|
      format.html {
        render text: "<span style='font-size:40px'>“</span>" + transcript.strip.gsub(/\n/,"<br/><br/>") + "<br/><br/><span style='font-size:40px'>”</span>"
      }
    end
  end

end
