class BookmarkSetsController < ApplicationController
  # GET /bookmark_sets
  # GET /bookmark_sets.json
  def index
    @bookmark_sets = BookmarkSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmark_sets }
    end
  end

  # GET /bookmark_sets/1
  # GET /bookmark_sets/1.json
  def show
    @bookmark_set = BookmarkSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark_set }
    end
  end

  # GET /bookmark_sets/new
  # GET /bookmark_sets/new.json
  def new
    @bookmark_set = BookmarkSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark_set }
    end
  end

  # GET /bookmark_sets/1/edit
  def edit
    @bookmark_set = BookmarkSet.find(params[:id])
  end

  # POST /bookmark_sets
  # POST /bookmark_sets.json
  def create
    @bookmark_set = BookmarkSet.new(params[:bookmark_set])

    respond_to do |format|
      if @bookmark_set.save
        format.html { redirect_to @bookmark_set, notice: 'Bookmark set was successfully created.' }
        format.json { render json: @bookmark_set, status: :created, location: @bookmark_set }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmark_sets/1
  # PUT /bookmark_sets/1.json
  def update
    @bookmark_set = BookmarkSet.find(params[:id])

    respond_to do |format|
      if @bookmark_set.update_attributes(params[:bookmark_set])
        format.html { redirect_to @bookmark_set, notice: 'Bookmark set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmark_sets/1
  # DELETE /bookmark_sets/1.json
  def destroy
    @bookmark_set = BookmarkSet.find(params[:id])
    @bookmark_set.destroy

    respond_to do |format|
      format.html { redirect_to bookmark_sets_url }
      format.json { head :no_content }
    end
  end
end
