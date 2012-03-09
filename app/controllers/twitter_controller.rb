class TwitterController < ApplicationController
  def authorize
    client = TwitterOAuth::Client.new(
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET
    )
    request_token = client.request_token(oauth_callback: callback_url)
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
      redirect_to edit_registration_path(resource), notice: "Authorization failed."
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
    
    redirect_to @issue
  end
end
