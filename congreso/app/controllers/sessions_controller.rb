include ApplicationHelper

class SessionsController < ApplicationController

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

end
