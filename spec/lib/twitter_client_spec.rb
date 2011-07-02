require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
module EM
  describe TwitterClient do
    it "gets userinfo" do
      EM::TwitterClient.new()
      credentials = {
        :consumer_key     => '0MPdbQLyNtSLHJfviCMLw',
        :consumer_secret  => 'ePGFhgOv5loBGDW1vqwxsqR9ZxRDmJEGGqAI9wWlc',
        :access_token     => '15177334-yCujPwYTUX0V3Rbub0sjID1H4SEJh6pdSkoRxK3w',
        :access_token_secret => 'eKGDe6jUhLFk5PCxcV1rXfGAQCMvIreCMwvGdVKoA'
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