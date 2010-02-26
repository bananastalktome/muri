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
        
        @url.host =~ /^img([0-9]*?)\.imageshack\.us/i
        @info[:server_id] = $1
        url_common = "http://img#{@info[:server_id]}.imageshack.us"
        
        if @url.path =~ /^\/i\/([a-z0-9]*?)\.([a-z0-9]*?)\//i
          @info[:media_id] = $1
          @info[:content_type] = $2
        elsif @url.path =~ /^\/img([0-9]*?)\/([0-9]*?)\/([a-z0-9]*?)\.([a-z0-9]*?)/i
          #server_id = $2
          @info[:media_id] = $3
          @info[:content_type] = $4
          @info[:url] = "#{url_common}/img#{@info[:server_id]}/#{@info[:server_id]}/#{@info[:media_id]}.#{@info[:content_type]}"
        end
        
        if self.parsed?
          @info[:media_url] = "#{url_common}/i/#{@info[:media_id]}.#{@info[:content_type]}/"
        end
        
        self
      end       
      
      def self.parsable?(uri)
        uri.host =~ /^img([0-9]*?)\.imageshack\.us$/i #/^(img([0-9]*?)\.imageshack\.us)|(yfrog\.com)/i
      end  
      
    end
  end
end
# http://img178.imageshack.us/i/dsc01576lo7.jpg/
# http://img178.imageshack.us/img178/773/dsc01576lo7.jpg
# http://yfrog.com/4ydsc01576lo7j

# http://img30.imageshack.us/img30/4184/rush02.mp4
# http://img30.imageshack.us/i/rush02.mp4/
# http://yfrog.us/0urush02z
