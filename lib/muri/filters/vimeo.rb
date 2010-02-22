require 'cgi'
class MURI
  module Filter
    module Vimeo

      def self.included(base)
        base.class_eval do
          self::PARSERS["vimeo.com"] = "vimeo_parse"
        end
      end
      
      def vimeo_parse
        
        @info[:service] = 'Vimeo'
        
        if @url.path =~ /^([0-9]*)/
          @info[:media_id] = $1
        elsif (@url.path =~ /^moogaloop\.swf/i)
          params = CGI::parse(@url.query)
          if params.include?("clip_id")
            @info[:media_id] = params["clip_id"].first if params["clip_id"].first =~ /([0-9]*)/
          end
        end
        @info[:media_url] = "http://vimeo.com/" + @info[:media_id] if !@info.media_id.nil?

        self
      end
      
    end
  end
end
# http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" 
# http://vimeo.com/7312128