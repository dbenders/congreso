# encoding: UTF-8
class Admin::BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @session = Session.find(params[:session_id])
    @bookmarks = @session.bookmarks
    @text_bookmarks = @session.text_bookmarks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  def match
    @session = Session.find(params[:session_id])
    @session.match_bookmarks
    respond_to do |format|
      format.html { redirect_to session_bookmarks_path(@session), notice: 'Bookmarks were successfully matched.' }    
      format.json { render json: @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.json
  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def toggle_matchtyp
    @bookmark = Bookmark.find(params[:bookmark_id])
    if @bookmark.matchtyp == 'manual'
      @bookmark.matchtyp = 'auto'
    else
      @bookmark.matchtyp = 'manual'
    end
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.text { render text: @bookmark.matchtyp }
        format.json { render json: @bookmark, status: :updated, location: session_bookmark_path(@bookmark.session,@bookmark) }
      else
        format.html { render action: "edit" }
        format.text { render text: "???" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end    


  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render json: @bookmark, status: :created, location: @bookmark }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])
    respond_to do |format|      
      @bookmark.text_bookmark = TextBookmark.find(params[:bookmark][:text_bookmark_id])
      if @bookmark.update_attributes(params[:bookmark].except(:text_bookmark_id))
        format.html { redirect_to session_bookmark_path(@bookmark.session,@bookmark), notice: 'Bookmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end
end
