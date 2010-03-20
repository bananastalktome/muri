require 'cgi'
class Muri
  module Filter
    module Youtube

      YOUTUBE_VIDEO = "video"
      YOUTUBE_PLAYLIST = "playlist"

      def self.included(base)
        base.class_eval do 
          self::PARSERS[Muri::Filter::Youtube] = "youtube_parse"
        end
      end
      
      def youtube_parse
        @info[:service] = 'Youtube'
        url_common = "http://www.youtube.com"
        params = @url.query.nil? ? {} : CGI::parse(@url.query)#.each {|k,v| b[k] = v.first}
        
        if (@url.path =~ /^\/watch$/i) && params.include?("v")
          @info[:media_id] = params["v"].first
          @info[:media_api_type] = YOUTUBE_VIDEO
        elsif (@url.path =~ /\/v\/([a-z0-9\-\_]+)/i)
          @info[:media_id] = $1
          @info[:media_api_type] = YOUTUBE_VIDEO
        elsif (@url.path =~ /^\/p\/([a-z0-9\-\_]+)/i)
          @info[:media_id] = $1
          @info[:media_api_type] = YOUTUBE_PLAYLIST
        elsif (@url.path =~ /^\/view\_play\_list$/i) && (params.include?('p'))
          @info[:media_id] = params['p'].first
          @info[:media_api_type] = YOUTUBE_PLAYLIST
        end
        
        if self.valid?
          if @info[:media_api_type] == YOUTUBE_VIDEO
            @info[:website] = "#{url_common}/watch?v=#{@info[:media_id]}"
            @info[:media_url] = "#{url_common}/v/#{@info[:media_id]}"
            @info[:media_thumbnail] = "http://i.ytimg.com/vi/#{@info[:media_id]}/default.jpg"
          elsif @info[:media_api_type] == YOUTUBE_PLAYLIST
            @info[:website] = "#{url_common}/view_play_list?p=#{@info[:media_id]}"
            @info[:media_url] = "#{url_common}/p/#{@info[:media_id]}"
          end
          @info[:media_api_id] = @info[:media_id]
        else
          raise UnsupportedURI
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
