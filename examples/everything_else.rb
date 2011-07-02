require File.expand_path('../../lib/em-twitter-client/twitter_client', __FILE__)
require 'eventmachine'
require 'em-http'
require 'em-http/middleware/oauth'
require 'em-http/middleware/json_response'
require 'em-synchrony/em-http'
require "em-synchrony"
require "em-synchrony/em-http"
@data = []
oauth = {:consumer_key     => 'YOUR KEY',
         :consumer_secret  => 'YOUR SECRED',
         :access_token     => 'TOKEN',
         :access_token_secret => 'SECRET'
       }

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.rate_limit
  twitter.mentions do |data|
    @data = data
    puts data.flatten.inspect
    EM.stop
  end
end

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.rate_limit
  twitter.home_timeline(2) do |data|
    @data = data
    puts data.flatten.inspect
    EM.stop
  end
end

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.rate_limit
  twitter.user_timeline('sreeix', 2) do |data|
    @data = data
    puts data.flatten.inspect
    EM.stop
  end
end

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.rate_limit
  twitter.user_friends('markhneedham', 2) do |data|
    @data = data
    puts data.flatten.size
    EM.stop
  end
end