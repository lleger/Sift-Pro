class AthletesController < ApplicationController
  before_filter :authorize_admin
  
  # GET /athletes
  # GET /athletes.json
  def index
    @sports = Sport.scoped_by_university_id(current_university.id).order("name ASC")
    @athletes = Athlete.scoped_by_university_id(current_university.id).order("name ASC").page(params[:page])
    if params[:filter].present? && params[:filter] != "all"
      @athletes = Athlete.includes(:sport).scoped_by_university_id(current_university.id).where("sports.name like '#{params[:filter]}'").order("athletes.name ASC").page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @athletes }
    end
  end

  # GET /athletes/1
  # GET /athletes/1.json
  def show
    @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @athlete }
    end
  end

  # GET /athletes/new
  # GET /athletes/new.json
  def new
    @athlete = Athlete.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @athlete }
    end
  end

  # GET /athletes/1/edit
  def edit
    @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])
  end

  # POST /athletes
  # POST /athletes.json
  def create
    @athlete = Athlete.new(params[:athlete])
    @athlete.university = current_university

    respond_to do |format|
      if @athlete.save
        format.html { redirect_to @athlete, notice: 'Athlete was successfully created.' }
        format.json { render json: @athlete, status: :created, location: @athlete }
      else
        format.html { render action: "new" }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /athletes/1
  # PUT /athletes/1.json
  def update
    @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])

    respond_to do |format|
      if @athlete.update_attributes(params[:athlete])
        format.html { redirect_to @athlete, notice: 'Athlete was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1
  # DELETE /athletes/1.json
  def destroy
    @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])
    @athlete.destroy

    respond_to do |format|
      format.html { redirect_to athletes_url }
      format.json { head :no_content }
    end
  end
  
  def authorize
    client = TwitterOAuth::Client.new(
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET
    )
    request_token = client.request_token(oauth_callback: callback_athlete_url)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end
  
  def callback
    client = TwitterOAuth::Client.new(
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET
    )
    access_token = client.authorize(
      session[:request_token],
      session[:request_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    )
    if client.authorized?
      @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])
      @athlete.token = access_token.token
      @athlete.secret = access_token.secret
      @athlete.save
      session[:request_token] = nil
      session[:request_token_secret] = nil
      redirect_to @athlete, notice: "Authorization success!"
    else
      redirect_to athletes_path, notice: "Authorization failed."
    end
  end
  
  def tweet
    @athlete = Athlete.scoped_by_university_id(current_university.id).find(params[:id])
  end
  
  def post
    @tweet = params[:tweet][:text]
    @offensive_words = Array.new
    Blacklist.all_with_default.each do |naughty|
      @offensive_words << naughty if @tweet =~ Regexp.new(naughty)
    end
    
    @issue = Issue.create(tweet: @tweet, blacklisted_words: @offensive_words.join(", "), university_id: current_university.id, athlete_id: params[:id], approved: false)
    @issue.save
  end
end
