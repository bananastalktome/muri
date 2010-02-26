require 'cgi'
class Muri
  module Filter
    module Photobucket

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Photobucket] = "photobucket_parse"
        end
      end
      
      def photobucket_parse
        @info[:service] = 'Photobucket'
        
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
        uri.host =~ /^([a-zA-Z0-9]*?)\.photobucket\.com/i
      end  
      
    end
  end
end

# http://media.photobucket.com/image/searchterm/pbapi/file.jpg (search result)
# http://s123.photobucket.com/albums/v214/pbapi/?action=view&current=file.jpg (full view)


# http://pic.pbsrc.com/dev_help/WebHelpPublic/PhotobucketPublicHelp.htm -> Conventions -> URL Structures