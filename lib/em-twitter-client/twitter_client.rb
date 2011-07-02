module EventMachine

  ## Takes the following hash
  ## {:consumer_key     => '',
  ##  :consumer_secret  => '',
  ##  :access_token     => '',
  ##  :access_token_secret => ''
  ## }
  
  class TwitterClient
    attr_reader :api_host
    attr_accessor :errback
    
    def initialize(oauth_config)
      EventMachine::HttpRequest.use EventMachine::Middleware::JSONResponse
      @oauth = oauth_config
      @api_host = 'http://api.twitter.com'
      @errback = Proc.new {|data| puts data.inspect}
    end
    
    def rate_limit(&blk)
      http = connection("1/account/rate_limit_status.json").get
      http.callback do 
         @current_ratelimit = http.response
         puts http.response.inspect
         blk(@current_ratelimit) if block_given?
      end
    end
    
    def user_info(user, &blk)
      path = "1/users/show.json?screen_name=#{user.strip}"
      http = connection(path).aget
      http.callback { yield(http.response) if block_given?}
      http.errback { @errback.call(http.response) } 
      self
    end
 
    def user_friends(user, pages = 1, &blk)
      multi = EventMachine::Synchrony::Multi.new
      Array(1..pages).each do |page|
        conn = connection("1/statuses/friends.json?screen_name=#{user}&page=#{page}")
        multi.add(page, conn.aget)
        puts "Addin 1/statuses/friends.json?screen_name=#{user}&page=#{page}"
      end
      
      process_paged_responses multi.perform, blk
    end

    def user_timeline(user, pages = 1, &blk)
      multi = EventMachine::Synchrony::Multi.new
      Array(1..pages).each do |page|
        conn = connection("1/statuses/user_timeline.json?screen_name=#{user}&page=#{page}&count=200")
        multi.add(page, conn.aget)
        puts "Addin 1/statuses/user_timeline.json?screen_name=#{user}&page=#{page}"
      end
      process_paged_responses multi.perform, blk
    end   

    # these are private  for the user. as in only available for that user.
    def home_timeline(pages = 1, &blk)
      multi = EventMachine::Synchrony::Multi.new
      Array(1..pages).each do |page|
        conn = connection("1/statuses/home_timeline.json?page=#{page}&count=200")
        multi.add(page, conn.aget)
        puts "Addin 1/statuses/home_timeline.json?page=#{page}"
      end
      process_paged_responses multi.perform, blk
    end  

    def mentions(pages = 1, &blk)
      multi = EventMachine::Synchrony::Multi.new
      Array(1..pages).each do |page|
        conn = connection("1/statuses/mentions.json?page=#{page}&count=200")
        multi.add(page, conn.aget)
        puts "Addin 1/statuses/mentions.json?page=#{page}"
      end
      process_paged_responses multi.perform, blk
    end  

  private
    def process_paged_responses(res, blk)
      # puts res.responses
      response = Array(res.responses[:callback]).sort{|a,b| a.first <=> b.first}.collect{|a,b| b.response}
      blk.call(response)
      errors = Array(res.responses[:errback]).sort{|a,b| a.first <=> b.first}.collect{|a,b| b.response}
      puts res.responses[:errback].inspect
      @errback.call(errors) unless errors.empty?
    end
    
    def connection(url)
      EventMachine::HttpRequest.new("#{@api_host}/#{url}").tap {|c| c.use EventMachine::Middleware::OAuth, @oauth}
    end
  end
end




