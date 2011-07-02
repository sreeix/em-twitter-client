class TwitterUser

  def initialize(user, oauth_config)
    @user = user
    @twitter = TwitterClient.new(oauth_config)
  end
  
  def info(&blk)
    @twitter.info(@user, blk)
  end

  def mentions(page = 1, &blk)
    @twitter.mentions(page, blk)
  end

  def timeline(page = 1, &blk)
    @twitter.home_timeline(page, blk)
  end

  def user_timeline(page = 1, &blk)
    @twitter.user_timeline(@user, page, blk)
  end
end