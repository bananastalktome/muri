class Muri
  module Filter
    module Twitpic
      
      TWITPIC_PHOTO = 'photo'
      
      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Twitpic] = "twitpic_parse"
        end
      end
      
      def twitpic_parse
        @info[:service] = 'Twitpic'
        url_common = "http://twitpic.com"
        
        if @url.path =~ /^\/([a-z0-9]+)/i
          @info[:media_id] = $1
          @info[:website] = "#{url_common}/#{@info[:media_id]}"
          @info[:media_url] = "#{url_common}/show/large/#{@info[:media_id]}"
          @info[:media_thumbnail] = "#{url_common}/show/thumb/#{@info[:media_id]}"          
          @info[:media_api_type] = TWITPIC_PHOTO
        else
          raise UnsupportedURI          
        end

        # Twitpic does not have an API to pull photo info. Media ID is best guess
        @info[:media_api_id] = @info[:media_id]
        
        self
      end            
 
      def self.parsable?(uri)
        uri.host =~ /^twitpic\.com$/i
      end
      
    end
  end
end
# http://twitpic.com/17d7th
# http://twitpic.com/show/large/17d7th
# http://twitpic.com/show/thumb/17d7th

# http://twitpic.com/api.do