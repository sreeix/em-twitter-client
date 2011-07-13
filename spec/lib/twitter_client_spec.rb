require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
module EM
  describe TwitterClient do
    it "gets userinfo" do
      credentials = {:consumer_key     => 'LALA',
               :consumer_secret  => 'FOO',
               :access_token     => 'LALA',
               :access_token_secret => 'LALA'
             }
        EM.run do
          tc = EM::TwitterClient.new(credentials)
          timeline  = tc.user_timeline('sreeix')
          timeline.callback do
            timeline.size.should_not == 0
            EM.stop
          end
        end
    end
  end
end