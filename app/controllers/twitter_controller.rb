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
      @user = current_user
      @user.token = access_token.token
      @user.secret = access_token.secret
      @user.save
      session[:request_token] = nil
      session[:request_token_secret] = nil
      redirect_to root_path, notice: "Authorization success!"
    else
      redirect_to edit_registration_path(resource), notice: "Authorization failed."
    end
  end
  
  def post
    @tweet = params[:tweet][:text]
    @offensive_words = Blacklist.find_offensive_words(@tweet)
    
    if @offensive_words.length > 0
      @issue = Issue.create(tweet: @tweet, blacklisted_words: @offensive_words.join(", "), university_id: current_university.id, athlete_id: current_user.id, approved: false)
      @issue.save
      redirect_to @issue
    else
      user = User.find_by_email("matsuflex7060@gmail.com")
      client = TwitterOAuth::Client.new(
        consumer_key: TWITTER_CONSUMER_KEY,
        consumer_secret: TWITTER_CONSUMER_SECRET,
        :token => user.token, 
        :secret => user.secret
      )
      if client.authorized?
        client.update(@tweet)
        redirect_to root_path, notice: "Tweet posted!"        
      else
        redirect_to authorize_path
      end
    end
  end
end
