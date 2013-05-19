include ApplicationHelper

class Admin::SessionsController < ApplicationController

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show    
    @tbk = TextBookmark.find(params[:tbk]) if params[:tbk]
    if params[:period] and params[:meeting]
      @session = Session.find_by_period_and_meeting(params[:period],params[:meeting])
    else
      @session = Session.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  def bookmarks
    session = Session.find(params[:session_id])
    xml = Builder::XmlMarkup.new  
    xml.instruct!
    xmldata = xml.data do
      session.bookmark_sets.find_by_typ(params[:type]||'manualmatch').bookmarks.each do |bk|
        attr = {         
          :title => (bk.person)? bk.person.lastname : bk.title,
          :start => (session.date + bk.pos.seconds).strftime('%b %d %Y %H:%M:%S GMT%z')
        }
        if bk.length
          attr[:end] = (session.date + bk.pos.seconds + bk.length.seconds).strftime('%b %d %Y %H:%M:%S GMT%z')
          attr[:durationEvent] = true
        else
          attr[:durationEvent] = false
        end
        xml.event(attr)
      end
    end

    respond_to do |format|
      format.xml { render xml: xmldata }
    end
  end

  def segments
    session = Session.find(params[:session_id])
    @segments = session.transcript_segments
    if params[:type]
      @segments = @segments.select {|segm| segm[:type] == params[:type].to_sym} 
    end    
    data = {:dateTimeFormat => 'iso8601'}
    data[:events] = @segments.collect do |segm| 
      {:start => (session.date + segm[:begin].seconds).strftime('%b %d %Y %H:%M:%S GMT%z'), 
       :title => segm[:name],
       :durationEvent => false
     }
    end
    data[:events] = data[:events][0..1]
    xml = Builder::XmlMarkup.new  
    xml.instruct!
    xmldata = xml.data do
      @segments.each do |segm|
        xml.event(
          :title => (segm[:name]||segm[:speaker]||"").titleize, 
          :start => (session.date + segm[:begin].seconds).strftime('%b %d %Y %H:%M:%S GMT%z'), 
          :end => (session.date + segm[:end].seconds).strftime('%b %d %Y %H:%M:%S GMT%z'), 
          :durationEvent => (params[:duration]||'true').to_bool
          )
      end
    end

    respond_to do |format|
      format.xml { render xml: xmldata }
      format.json { render json: @segments }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = Session.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(params[:session].except(:chamber_id))
    @chamber = Chamber.find(params[:session][:chamber_id])
    @session.chamber = @chamber
    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render json: @session, status: :created, location: @session }
      else
        format.html { render action: "new" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = Session.find(params[:id])
    @chamber = Chamber.find(params[:session][:chamber_id])
    respond_to do |format|
      if @session.chamber = @chamber and @session.you_tube_video_ids = params[:session][:you_tube_video_ids] and
                @session.update_attributes(params[:session].except(:chamber_id).except(:you_tube_video_ids))
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end
end
