require 'cgi'
class Muri
  module Filter
    module Youtube

      def self.included(base)
        base.class_eval do 
          self::PARSERS[Muri::Filter::Youtube] = "youtube_parse"
        end
      end
      
      def youtube_parse
        @info[:service] = 'Youtube'
        url_common = "http://www.youtube.com"
        
        if (@url.path == "/watch") && !@url.query.nil?
          params = CGI::parse(@url.query)
          @info[:media_id] = params["v"].first
        elsif (@url.path =~ /\/v\/([a-z0-9\-\_]*)/i)
          @info[:media_id] = $1
        end
        
        if self.parsed?
          @info[:media_url] = "#{url_common}/watch?v=#{@info[:media_id]}"
          @info[:website] = "#{url_common}/v/#{@info[:media_id]}"
          @info[:media_api_id] = @info[:media_id]
          @info[:media_thumbnail] = "http://i.ytimg.com/vi/#{@info[:media_id]}/default.jpg"
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