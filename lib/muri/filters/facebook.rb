require 'cgi'
class Muri
  module Filter
    module Facebook
      
      FACEBOOK_PHOTO = "photo"
      FACEBOOK_VIDEO = "video"
      
      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Facebook] = "facebook_parse"
        end
      end
      
      def facebook_parse
        @info[:service] = 'Facebook'
        
        url_common = "http://www.facebook.com"
        
        if @url.path =~ /^\/v\/([0-9]+)/
          @info[:media_id] = $1
          @info[:media_url] = "#{url_common}/v/#{@info[:media_id]}"
          @info[:media_api_id] = @info[:media_id]
          @info[:media_api_type] = FACEBOOK_VIDEO
        elsif (@url.path =~ /^\/photo\.php/i)
          params = CGI::parse(@url.query) if !@url.query.nil?
          if params.include?("pid") && params.include?("id") && params.include?("l")
            @info[:media_api_type] = FACEBOOK_PHOTO
            @info[:media_id] = params["pid"].first if (params["pid"].first =~ /([0-9]*)/)
            media_creator = params["id"].first if (params["id"].first =~ /([0-9]*)/)
            share_key = params["l"].first
            
            @info[:website] = "#{url_common}/photo.php?pid=#{@info[:media_id]}&l=#{share_key}&id=#{media_creator}"
            @info[:media_api_id] = { :pid => @info[:media_id], :user_id => media_creator }
          end
        end
        
        # Currently no API for video, but media_id is best guess value for such content
        #if self.parsed?
          #@info[:media_api_id] = @info[:media_id]
        #else
        if !self.parsed?
          raise UnsupportedURI
        end
        
        self
      end            
 
      def self.parsable?(uri)
        uri.host =~ /^(www\.)?facebook\.com$/i
      end
      
    end
  end
end

# http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063 (preview)
#   pid = photo id
#   id = user id
#   l = photo share key
# http://www.facebook.com/v/614695029223 (full)