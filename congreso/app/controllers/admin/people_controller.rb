class Admin::PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    if params[:chamber]
      @chamber = Chamber.find(params[:chamber])
      @people = @people.select {|p| p.chamber == @chamber} if @chamber
    end

    if params[:province]
      @province = Province.find(params[:province])
      @people = @people.select {|p| p.province == @province} if @province
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = get_person(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/card
  def card
    @person = get_person(params[:id])
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def update_data
    update_num_speeches
    respond_to do |format|
      format.html { redirect_to admin_people_path, notice: 'Num of speeches updated.' }
    end
  end    

private

  def update_num_speeches
    Person.all.each do |p|
      p.num_speeches = p.text_bookmarks.select {|tb| tb.bookmark && tb.bookmark.matchtyp == 'manual' }.count
      p.save!
    end
  end

  def get_person(id)
    p = params[:id].split('_')

    people = Person.find_all_by_username(p[0])
    people = Person.find_all_by_lastname(p[0].titleize) if people.empty?
    people = Person.find_all(params[:id]) if people.empty?

    if people.length == 1
      people[0]
    elsif p.length < 2
        nil
    else
      people.select{|person| person.firstname.downcase.start_with?(p[1])}[0]
    end
  end      


end
