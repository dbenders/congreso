# encoding: UTF-8

class Admin::TextBookmarksController < ApplicationController
  # GET /text_bookmarks
  # GET /text_bookmarks.json
  def index
    @sesion = Session.find(params[:session_id])
    @text_bookmarks = @sesion.text_bookmarks
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_bookmarks }
    end    
  end

  # GET /sessions/1/text_bookmarks/1/merge_up
  def merge_up
    sesion = Session.find(params[:session_id])
    text_bookmark = TextBookmark.find(params[:text_bookmark_id])    
    prev_bookmark = sesion.text_bookmarks.select {|tbk| tbk.pos < text_bookmark.pos}[-1]
    prev_bookmark.length = (text_bookmark.pos + text_bookmark.length) - prev_bookmark.pos
    respond_to do |format|
      if prev_bookmark.save and text_bookmark.destroy
        format.html { redirect_to session_text_bookmark_path(prev_bookmark.session,prev_bookmark), notice: 'Text bookmarks were merged successfully.' }
      else
        format.html { render action: "edit" }
      end
    end    
  end

  def rebuild
    sesion = Session.find(params[:session_id])
    sesion.rebuild_text_bookmarks
    respond_to do |format|
      format.html { redirect_to admin_session_text_bookmarks_path(sesion), notice: 'Text bookmark was successfully recreated.' }
      format.json { render json: TextBookmark.find_all_by_session_id(params[:session_id]), status: :created, location: admin_session_text_bookmarks_path(sesion) }
    end
  end

  def retag
    sesion = Session.find(params[:session_id])
    sesion.text_bookmarks.each do |tbk|
      #if tbk.tags.nil? || tbk.tags.empty?
        tbk.tags = tbk.candidate_tags
        tbk.save!
      #end
    end
    respond_to do |format|
      format.html { redirect_to admin_session_text_bookmarks_path(sesion), notice: 'Text bookmark was successfully retagged.' }
      format.json { render json: TextBookmark.find_all_by_session_id(params[:session_id]), status: :created, location: admin_session_text_bookmarks_path(sesion) }
    end      
  end

  # GET /bookmarks/1/transcript
  # GET /bookmarks/1/transcript.json
  def transcript
    @text_bookmark = TextBookmark.find(params[:text_bookmark_id])
    transcript = @text_bookmark.text
    respond_to do |format|
      format.html {
        render text: "<span style='font-size:40px'>“</span>" + transcript.strip.gsub(/\n/,"<br/><br/>") + "<br/><br/><span style='font-size:40px'>”</span>"
      }
    end
  end

  def up
    text_bookmark = TextBookmark.find(params[:text_bookmark_id])
    prev_bookmark = text_bookmark.bookmark
    new_bookmark = text_bookmark.session.bookmarks.select {|bk| bk.pos < text_bookmark.bookmark.pos}.max
    text_bookmark.bookmark = new_bookmark
    respond_to do |format|
      if text_bookmark.save
        format.html { redirect_to session_text_bookmark_path(text_bookmark.session,text_bookmark), notice: 'Text bookmark was moved up successfully.' }
        format.json { render json: {:prev_bookmark => prev_bookmark.id, :current_bookmark => new_bookmark.id} }
      else
        format.html { render action: "edit" }
        format.json { render json: text_bookmark.errors, status: :unprocessable_entity }        
      end
    end
  end

  def down
    text_bookmark = TextBookmark.find(params[:text_bookmark_id])
    prev_bookmark = text_bookmark.bookmark    
    new_bookmark = text_bookmark.session.bookmarks.select {|bk| bk.pos > text_bookmark.bookmark.pos}.min
    text_bookmark.bookmark = new_bookmark
    respond_to do |format|
      if text_bookmark.save
        format.html { redirect_to session_text_bookmark_path(text_bookmark.session,text_bookmark), notice: 'Text bookmark was moved up successfully.' }
        format.json { render json: {:prev_bookmark => prev_bookmark.id, :current_bookmark => new_bookmark.id} }
      else
        format.html { render action: "edit" }
        format.json { render json: text_bookmark.errors, status: :unprocessable_entity }        
      end
    end
  end


  # GET /text_bookmarks/1
  # GET /text_bookmarks/1.json
  def show
    @text_bookmark = TextBookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_bookmark }
    end
  end

  # GET /text_bookmarks/new
  # GET /text_bookmarks/new.json
  def new
    @session = Session.find(params[:session_id])
    @text_bookmark = TextBookmark.new
    @text_bookmark.session = @session
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_bookmark }
    end
  end

  # GET /text_bookmarks/1/edit
  def edit
    @text_bookmark = TextBookmark.find(params[:id])
  end

  # POST /text_bookmarks
  # POST /text_bookmarks.json
  def create
    @text_bookmark = TextBookmark.new(params[:text_bookmark].except(:person_id))
    if not params[:text_bookmark][:person_id].empty?
      @text_bookmark.person = Person.find(params[:text_bookmark][:person_id]) 
    else
      @text_bookmark.person = nil
    end    
    @session = Session.find(params[:session_id])    
    @text_bookmark.session = @session
    respond_to do |format|
      if @text_bookmark.save
        format.html { render action: "edit" }
        #format.html { redirect_to admin_session_text_bookmarks_path(@session), notice: 'Text bookmark was successfully created.' }
        format.json { render json: @text_bookmark, status: :created, location: @text_bookmark }
      else
        format.html { render action: "new" }
        format.json { render json: @text_bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_bookmarks/1
  # PUT /text_bookmarks/1.json
  def update
    @text_bookmark = TextBookmark.find(params[:id])
    if not params[:text_bookmark][:person_id].empty?
      @text_bookmark.person = Person.find(params[:text_bookmark][:person_id]) 
    else
      @text_bookmark.person = nil
    end
    respond_to do |format|
      if @text_bookmark.update_attributes(params[:text_bookmark].except(:person_id))
        format.html { render action: "edit" }
        #format.html { redirect_to session_text_bookmarks_path(@text_bookmark.session), notice: 'Text bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_bookmarks/1
  # DELETE /text_bookmarks/1.json
  def destroy
    @text_bookmark = TextBookmark.find(params[:id])
    @text_bookmark.destroy

    respond_to do |format|
      format.html { redirect_to admin_session_text_bookmarks_path(@text_bookmark.session) }
      format.json { head :no_content }
    end
  end
end
