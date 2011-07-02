require File.expand_path('../../lib/em-twitter-client/twitter_client', __FILE__)
require 'eventmachine'
require 'em-http'
require 'em-http/middleware/oauth'
require 'em-http/middleware/json_response'
require 'em-synchrony/em-http'
require "em-synchrony"
require "em-synchrony/em-http"

oauth = {:consumer_key     => 'tVcGxZZx9L2g7bFg2uiwGA',
         :consumer_secret  => 'Rxh9kk8lqPgQgX04kPNr5TSp2kxgIvIZSbEcMUpC1Hg',
         :access_token     => '237729849-imrgHKImaNXgSC9eThYGg0f0IMy9CkDCUhbyXwAU',
         :access_token_secret => 'esWHYtuPnmnzMqAP6OC85SOOmUhUpbaLMoHFnO3vFuI'
       }

EM.synchrony do 
  twitter = EM::TwitterClient.new(oauth)
  twitter.search('tour de france', 4, :lang => 'fr' ) do |data|
    puts data.inspect
    EM.stop
  end
end