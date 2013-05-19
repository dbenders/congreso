class ChambersController < ApplicationController

  # GET /chambers
  # GET /chambers.json
  def index
    @chambers = Chamber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chambers }
    end
  end

  # GET /chambers/1
  # GET /chambers/1.json
  def show
    @chamber = Chamber.find_by_name(params[:id]) ||
               Chamber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chamber }
    end
  end

end
