class YouTubeVideosController < ApplicationController
  # GET /you_tube_videos
  # GET /you_tube_videos.json
  def index
    @you_tube_videos = YouTubeVideo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @you_tube_videos }
    end
  end

  # GET /you_tube_videos/1
  # GET /you_tube_videos/1.json
  def show
    @you_tube_video = YouTubeVideo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @you_tube_video }
    end
  end

  # GET /you_tube_videos/new
  # GET /you_tube_videos/new.json
  def new
    @you_tube_video = YouTubeVideo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @you_tube_video }
    end
  end

  # GET /you_tube_videos/1/edit
  def edit
    @you_tube_video = YouTubeVideo.find(params[:id])
  end

  # POST /you_tube_videos
  # POST /you_tube_videos.json
  def create
    @you_tube_video = YouTubeVideo.new(params[:you_tube_video])

    respond_to do |format|
      if @you_tube_video.save
        format.html { redirect_to @you_tube_video, notice: 'You tube video was successfully created.' }
        format.json { render json: @you_tube_video, status: :created, location: @you_tube_video }
      else
        format.html { render action: "new" }
        format.json { render json: @you_tube_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /you_tube_videos/1
  # PUT /you_tube_videos/1.json
  def update
    @you_tube_video = YouTubeVideo.find(params[:id])
    @session = Session.find(params[:you_tube_video][:session_id])
    respond_to do |format|
      if @you_tube_video.session = @session and @you_tube_video.update_attributes(params[:you_tube_video].except(:session_id))
        format.html { redirect_to @you_tube_video, notice: 'You tube video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @you_tube_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /you_tube_videos/1
  # DELETE /you_tube_videos/1.json
  def destroy
    @you_tube_video = YouTubeVideo.find(params[:id])
    @you_tube_video.destroy

    respond_to do |format|
      format.html { redirect_to you_tube_videos_url }
      format.json { head :no_content }
    end
  end
end
