require File.expand_path('../../lib/em-twitter-client/twitter_client', __FILE__)
# require 'eventmachine'
# require 'em-http'
# require 'em-http/middleware/oauth'
# require 'em-http/middleware/json_response'
# require 'em-synchrony/em-http'
require 'eventmachine'
require 'em-http'
require 'em-http/middleware/oauth'
require 'em-http/middleware/json_response'
require 'em-synchrony/em-http'
require "em-synchrony"
require "em-synchrony/em-http"

oauth = {:consumer_key     => 'YOUR KEY',
         :consumer_secret  => 'YOUR SECRED',
         :access_token     => 'TOKEN',
         :access_token_secret => 'SECRET'
       }

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.user_info('sreeix') do |data|
    puts data.inspect
    EM.stop
  end
end