class BlacklistsController < ApplicationController
  # GET /blacklists
  # GET /blacklists.json
  def index
    @blacklists = Blacklist.scoped_by_university_id(current_university.id).order("word asc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blacklists }
    end
  end

  # GET /blacklists/1
  # GET /blacklists/1.json
  def show
    @blacklist = Blacklist.scoped_by_university_id(current_university.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blacklist }
    end
  end

  # GET /blacklists/new
  # GET /blacklists/new.json
  def new
    @blacklist = Blacklist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blacklist }
    end
  end

  # GET /blacklists/1/edit
  def edit
    @blacklist = Blacklist.scoped_by_university_id(current_university.id).find(params[:id])
  end

  # POST /blacklists
  # POST /blacklists.json
  def create
    @blacklist = Blacklist.new(params[:blacklist])
    @blacklist.university = current_university
    @blacklist.user = current_user

    respond_to do |format|
      if @blacklist.save
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully created.' }
        format.json { render json: @blacklist, status: :created, location: @blacklist }
      else
        format.html { render action: "new" }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blacklists/1
  # PUT /blacklists/1.json
  def update
    @blacklist = Blacklist.scoped_by_university_id(current_university.id).find(params[:id])

    respond_to do |format|
      if @blacklist.update_attributes(params[:blacklist])
        format.html { redirect_to @blacklist, notice: 'Blacklist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blacklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blacklists/1
  # DELETE /blacklists/1.json
  def destroy
    @blacklist = Blacklist.scoped_by_university_id(current_university.id).find(params[:id])
    @blacklist.destroy

    respond_to do |format|
      format.html { redirect_to blacklists_url }
      format.json { head :no_content }
    end
  end
end
