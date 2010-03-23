require 'cgi'
class Muri
  module Filter
    module Vimeo
      
      VIMEO_VIDEO = "video"
      VIMEO_ALBUM = "album"
      
      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Vimeo] = "vimeo_parse"
        end
      end
      
      def vimeo_parse
        @info[:service] = 'Vimeo'
        params = @url.query.nil? ? {} : CGI::parse(@url.query)#.each {|k,v| b[k] = v.first}

        if @url.path =~ /^\/(album\/)?([0-9]+)\/?$/i
          @info[:media_id] = $2
          @info[:media_api_type] = $1.nil? ? VIMEO_VIDEO : VIMEO_ALBUM
        elsif @url.path =~ /^\/groups\/([0-9a-z\@\-\_]+)\/videos\/([0-9]+)\/?$/i
          @info[:media_id] = $2
          @info[:media_api_type] = VIMEO_VIDEO
        elsif ((@url.path =~ /^\/moogaloop\.swf$/i) && (params.include?("clip_id")) && (params["clip_id"].first =~ /^([0-9]+)$/))
          @info[:media_id] = params["clip_id"].first
          @info[:media_api_type] = VIMEO_VIDEO
        else
          raise UnsupportedURI
        end

        @info[:media_api_id] = @info[:media_id]
        album = (@info[:media_api_type] == VIMEO_ALBUM) ? "album/" : ""
        @info[:website] = "http://vimeo.com/#{album}#{@info[:media_id]}"
        if @info[:media_api_type] == VIMEO_VIDEO
          @info[:media_url] = "http://vimeo.com/moogaloop.swf?clip_id=#{@info[:media_id]}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1"
        end
        
        self
      end            
 
      def self.parsable?(uri)
        uri.host =~ /^(www\.)?vimeo\.com$/i
      end
      
    end
  end
end
# http://www.vimeo.com/groups/beyondthestill/videos/9394829
# http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" 
# http://vimeo.com/7312128
# http://vimeo.com/album/89702