class TwitterUser
  API_HOST = 'http://api.twitter.com'
  
  def initialize(user, oauth_config)
    @user = user
    @oauth = oauth_config
  end
  
  def info(&blk)
    TwitterClient.new(@oauth_config).info(@user, blk)
  end

  def mentions(page = 1, &blk)
    TwitterClient.new(@oauth_config).mentions(page, blk)
  end

  def timeline(page = 1, &blk)
    TwitterClient.new(@oauth_config).home_timeline(page, blk)
  end

  def user_timeline(page = 1, &blk)
    TwitterClient.new(@oauth_config).user_timeline(@user, page, blk)
  end
end