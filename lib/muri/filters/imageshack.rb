require 'cgi'
class Muri
  module Filter
    module Imageshack

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Imageshack] = "imageshack_parse"
        end
      end
      
      def imageshack_parse
        @info[:service] = 'Imageshack'
        
        if @url.path =~ /^\/([0-9]*)/
          @info[:media_id] = $1
        elsif (@url.path =~ /^\/moogaloop\.swf/i)
          params = CGI::parse(@url.query)
          if params.include?("clip_id")
            @info[:media_id] = params["clip_id"].first if (params["clip_id"].first =~ /([0-9]*)/)
          end
        end
        
        if self.parsed?
          @info[:media_url] = "http://vimeo.com/" + @info[:media_id].to_s
        end
        
        self
      end       
      
      def self.parsable?(uri)
        #uri.host =~ 
        false
      end  
      
    end
  end
end
# http://img178.imageshack.us/i/dsc01576lo7.jpg/
# http://img178.imageshack.us/img178/773/dsc01576lo7.jpg
# http://yfrog.com/4ydsc01576lo7j
