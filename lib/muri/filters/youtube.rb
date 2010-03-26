require 'cgi'
class Muri
  module Filter
    module Youtube
      
      protected
      YOUTUBE_VIDEO = "video"
      YOUTUBE_PLAYLIST = "playlist"

      def self.included(base)
        base.class_eval do 
          self::PARSERS[Muri::Filter::Youtube] = "youtube_parse"
        end
      end
      
      def youtube_parse
        self.media_service = 'Youtube'
        url_common = "http://www.youtube.com"
        params = self.url.query.nil? ? {} : CGI::parse(self.url.query)#.each {|k,v| b[k] = v.first}
        
        if (self.url.path =~ /^\/watch$/i) && params.include?("v")
          self.media_id = params["v"].first
          self.media_api_type = YOUTUBE_VIDEO
        elsif (self.url.path =~ /\/v\/([a-z0-9\-\_]+)/i)
          self.media_id = $1
          self.media_api_type = YOUTUBE_VIDEO
        elsif (self.url.path =~ /^\/p\/([a-z0-9\-\_]+)/i)
          self.media_id = $1
          self.media_api_type = YOUTUBE_PLAYLIST
        elsif (self.url.path =~ /^\/view\_play\_list$/i) && (params.include?('p'))
          self.media_id = params['p'].first
          self.media_api_type = YOUTUBE_PLAYLIST
        else
          raise UnsupportedURI          
        end
        
        self.media_api_id = self.media_id
        if self.media_api_type == YOUTUBE_VIDEO
          self.media_website = "#{url_common}/watch?v=#{self.media_id}"
          self.media_url = "#{url_common}/v/#{self.media_id}"
          self.media_thumbnail = "http://i.ytimg.com/vi/#{self.media_id}/default.jpg"
        elsif self.media_api_type == YOUTUBE_PLAYLIST
          self.media_website = "#{url_common}/view_play_list?p=#{self.media_id}"
          self.media_url = "#{url_common}/p/#{self.media_id}"
        end
        
        self
      end     
      def self.parsable?(uri)
        uri.host =~ /^(www\.)?youtube\.com$/i
      end      
    end
  end
end
# http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1& (direct)
# http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM (preview)

# PLAYLISTS
# http://www.youtube.com/p/57633EC69B4A10A2&hl=en_US&fs=1 (direct)
# http://www.youtube.com/view_play_list?p=57633EC69B4A10A2 (preview)
