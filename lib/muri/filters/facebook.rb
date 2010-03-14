require 'cgi'
class Muri
  module Filter
    module Facebook
      
      FACEBOOK_PHOTO = "photo"
      #FACEBOOK_VIDEO = "video"
      FACEBOOK_ALBUM = "album"
      
      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Facebook] = "facebook_parse"
        end
      end
      
      def facebook_parse
        @info[:service] = 'Facebook'
        params = @url.query.nil? ? {} : CGI::parse(@url.query)
        url_common = "http://www.facebook.com"
        
#         if @url.path =~ /^\/v\/([0-9]+)/
#           @info[:media_id] = $1
#           @info[:media_url] = "#{url_common}/v/#{@info[:media_id]}"
#           
#           # Currently no API for video, but media_id is best guess value for such content
#           @info[:media_api_id] = @info[:media_id]
#           @info[:media_api_type] = FACEBOOK_VIDEO
        if ((@url.path =~ /^\/photo\.php$/i) && 
            params.include?("pid") && params["pid"].first =~ /^([0-9]+)$/ && 
            params.include?("id") && params["id"].first =~ /^([0-9]+)$/ && 
            params.include?("l") && params["l"].first =~ /^([0-9a-z]+)$/i)
          
          @info[:media_api_type] = FACEBOOK_PHOTO
          @info[:media_id] = params["pid"].first
          media_creator = params["id"].first
          share_key = params["l"].first
          
          @info[:website] = "#{url_common}/photo.php?pid=#{@info[:media_id]}&l=#{share_key}&id=#{media_creator}"
        elsif ((@url.path =~ /^\/album\.php$/i) && 
            params.include?("aid") && params["aid"].first =~ /^([0-9]+)$/ && 
            params.include?("id") && params["id"].first =~ /^([0-9]+)$/ && 
            params.include?("l") && params["l"].first =~ /^([0-9a-z]+)$/i)
          
          @info[:media_api_type] = FACEBOOK_ALBUM
          @info[:media_id] = params["aid"].first
          media_creator = params["id"].first
          share_key = params["l"].first
          
          @info[:website] = "#{url_common}/album.php?aid=#{@info[:media_id]}&l=#{share_key}&id=#{media_creator}"
        end
        
        if self.valid?
          # The media_api_id is the PID which can be searched for in the facebook photos table          
          @info[:media_api_id] = (media_creator.to_i << 32) + @info[:media_id].to_i
        else
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
# http://www.facebook.com/album.php?aid=2131184&id=15201063&l=8917e51479
# http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063 (preview)
# database_pid = (USER_ID << 32) + PID
#   pid = photo id
#   id = user id
#   l = photo share key
# http://www.facebook.com/v/614695029223 (full)
# http://www.facebook.com/album.php?aid=2149275&id=15201063&l=99900807c3