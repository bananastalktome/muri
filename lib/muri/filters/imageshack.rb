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
        
        @url.host =~ /^img([0-9]*?)\.imageshack\.us/i
        @info[:img_id] = $1
        
        if @url.path =~ /^\/i\/([a-zA-Z0-9]*?)\.([a-zA-Z0-9]*?)\//i
          @info[:media_id] = $1
          @info[:content_type] = $2.downcase
        elsif @url.path =~ /^\/img([0-9]*?)\/([0-9]*?)\/([a-zA-Z0-9]*?)\.([a-zA-Z0-9]*?)/i
          server_id = $2
          @info[:media_id] = $3
          @info[:content_type] = $4.downcase
          @info[:url] = "http://img" + @info[:img_id] + ".imageshack.us/img" + @info[:img_id] + "/#{server_id}/" + @info[:media_id] + "." + @info[:content_type]
        end
        
        if self.parsed?
          @info[:media_url] = "http://img" + @info[:img_id] + ".imageshack.us/i/" + @info[:media_id] + "." + @info[:content_type] + "/"
        end
        
        self
      end       
      
      def self.parsable?(uri)
        uri.host =~ /^img([0-9]*?)\.imageshack\.us/i #/^(img([0-9]*?)\.imageshack\.us)|(yfrog\.com)/i
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
