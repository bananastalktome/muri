require 'cgi'
class Muri
  module Filter
    module Youtube

      def self.included(base)
        base.class_eval do
          #self::PARSERS["www.youtube.com"] = "youtube_parse"
          #self::PARSERS["youtube.com"] = "youtube_parse"  
          self::PARSERS[Muri::Filter::Youtube] = "youtube_parse"
        end
      end
      
      def youtube_parse
        @info[:service] = 'Youtube'
        
        if (@url.path == "/watch") && !@url.query.nil?
          params = CGI::parse(@url.query)
          @info[:media_id] = params["v"].first
        elsif (@url.path =~ /\/v\/([a-zA-Z0-9\-\_]*)/i)
          @info[:media_id] = $1
        end
        
        if self.parsed?
          @info[:media_url] = "http://www.youtube.com/watch?v=" + @info[:media_id]
          @info[:url] = "http://www.youtube.com/v/" + @info[:media_id]
        end
        
        self
      end     
      def self.parsable?(uri)
        uri.host =~ /^(www\.|)youtube\.com$/i
      end      
    end
  end
end
# http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&
# http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM