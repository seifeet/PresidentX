require 'net/http'
require 'securerandom'
require 'json'
require 'parallel'
require 'open-uri'

class ApiCall
    @@apiKey       = '132c9d1b0fd3687a4a7bdd42a7ca596cddd94ca0'

    def initialize(host, path)
        @apiURI       = URI.parse(host)
        @apiURI.path  = path
    end
end

class TweetCount < ApiCall
    def initialize(host, term, daysAgo)
        super(host, '/search.json')
        daysAgoStr = ""
        if daysAgo > 0
          daysAgoStr = daysAgo.to_s
        end

        params =
        {
            :q              => term,
            :window         => 'd'+daysAgoStr
        }
        @apiURI.query = URI.encode_www_form(params)
    end
    # add a new instance method
    def send
        result = nil
        #puts @apiURI.path + '?' +  @apiURI.query
        req = Net::HTTP::Get.new(@apiURI.path + '?' + @apiURI.query)
        
        res = Net::HTTP.start(@apiURI.hostname, @apiURI.port) do |http|
          http.request(req)
        end
        
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
            parsed_json = JSON.parse(res.body)
            
            response = parsed_json["response"]
            unless response.nil?
              total = response["total"]
              unless total.nil?
                result = total
              end
            end
        else
          puts "----------->Error<-----------"
          puts res.inspect
        end

        return result
    end
end

def getFeed(host, daysAgo)
   time = Time.now - (24*60*60) * daysAgo
  
   timeStr = time.strftime('"%b %d, %Y"')

   obamaTweetCount = TweetCount.new(host, 'obama', daysAgo)
   obamaCount = obamaTweetCount.send
   
   obamacareTweetCount = TweetCount.new(host, 'Obamacare', daysAgo)
   obamacareCount = obamacareTweetCount.send
   
   obamaAbortonTweetCount = TweetCount.new(host, 'obama+abortion', daysAgo)
   obamaAbortionCount = obamaAbortonTweetCount.send

   obamaEconomyTweetCount = TweetCount.new(host, 'obama+economy', daysAgo)
   obamaEconomyCount = obamaEconomyTweetCount.send

   obamaHealthcareTweetCount = TweetCount.new(host, 'obama+healthcare', daysAgo)
   obamaHealthcareCount = obamaHealthcareTweetCount.send
        
   romneyTweetCount = TweetCount.new(host, 'romney', daysAgo)
   romneyCount = romneyTweetCount.send
   
   romneyAbortonTweetCount = TweetCount.new(host, 'romney+abortion', daysAgo)
   romneyAbortionCount = romneyAbortonTweetCount.send

   romneyEconomyTweetCount = TweetCount.new(host, 'romney+economy', daysAgo)
   romneyEconomyCount = romneyEconomyTweetCount.send

   romneyHealthcareTweetCount = TweetCount.new(host, 'romney+healthcare', daysAgo)
   romneyHealthcareCount = romneyHealthcareTweetCount.send
   
   puts timeStr + "," + obamaCount.to_s + "," +
                        obamacareCount.to_s + "," +
                        obamaAbortionCount.to_s + "," +
                        obamaEconomyCount.to_s + "," +
                        obamaHealthcareCount.to_s + "," +
                        romneyCount.to_s + "," +
                        romneyAbortionCount.to_s + "," +
                        romneyEconomyCount.to_s + "," +
                        romneyHealthcareCount.to_s
end


#puts "Date, Obama, ObamaCare, ObamaAbortion, ObamaEconomy, ObamaHealthcare, Romney, RomneyAbortion, RomneyEconomy, RomneyHealthcare"
for i in 71..300
  getFeed("http://otter.topsy.com", i)
end







