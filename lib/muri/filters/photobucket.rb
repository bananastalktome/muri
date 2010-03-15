require 'cgi'
class Muri
  module Filter
    module Photobucket

      PHOTOBUCKET_MEDIA = "media"
      PHOTOBUCKET_ALBUM = "album"
      PHOTOBUCKET_GROUP_ALBUM = "group_album"

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Photobucket] = "photobucket_parse"
        end
      end
      
      def photobucket_parse
        @info[:service] = 'Photobucket'
        
        @url.host =~ /^([a-z0-9]*?[^(media)])\.photobucket\.com/i
        @info[:server_id] = $1.gsub(/([a-z]*)/i,"")
        
        if @url.path =~ /^\/albums\/(.+?)\/(.+?)\/((?:.+?\/)*)(.+?)\.(.+)/i #Images
          photobucket_id = $1
          media_creator = $2          
          album = $3
          @info[:media_id] = $4
          @info[:content_type] = $5
          url_common = "#{server_id}.photobucket.com/albums/#{photobucket_id}/#{media_creator}/#{album}"
          direct_url_suffix = "#{url_common}#{@info[:media_id]}.#{@info[:content_type]}"
          @info[:media_api_type] = PHOTOBUCKET_MEDIA
          @info[:media_url] = "http://i#{direct_url_suffix}"
          @info[:website] = "http://s#{url_common}?action=view&current=#{@info[:media_id]}.#{@info[:content_type]}"
        elsif @url.path =~ /^\/albums\/(.+?)\/(.+?)\/((?:.[^\/]+?)+)(?:\/|$)/i #Albums
          photobucket_id = $1
          media_creator = $2
          album = $3
          @info[:media_id] = "#{media_creator}/#{album}"
          url_common = "#{server_id}.photobucket.com/albums/#{photobucket_id}/#{media_creator}/#{album}"
          @info[:media_api_type] = PHOTOBUCKET_ALBUM
          @info[:website] = "http://s#{url_common}/"
        elsif @url.path =~ /^\/groups\/(.+?)\/(.+?)\/(.+?)\.(.+)/i #Group Images
          group = $1
          group_hash_value = $2
          @info[:media_id] = $3
          @info[:content_type] = $4
          url_common = "#{server_id}.photobucket.com/groups/#{group}/#{group_hash_value}"
          direct_url_suffix = "#{url_common}/#{@info[:media_id]}.#{@info[:content_type]}"
          @info[:media_api_type] = PHOTOBUCKET_MEDIA
          @info[:media_url] = "http://gi#{direct_url_suffix}"
          @info[:website] = "http://gs#{url_common}/?action=view&current=#{@info[:media_id]}.#{@info[:content_type]}"
        elsif @url.path =~ /^\/groups\/(.+)\/(.+?)(?:\/|$)/i #Group Album
          group = $1
          group_hash_value = $2
          url_common = "#{server_id}.photobucket.com/groups/#{group}/#{group_hash_value}"
          @info[:media_id] = group_hash_value
          @info[:website] = "http://gs#{url_common}/"
          @info[:media_api_type] = PHOTOBUCKET_GROUP_ALBUM
        end
        
        if self.valid?
          if @info[:media_api_type] == PHOTOBUCKET_MEDIA
            @info[:media_api_id] = @info[:media_url]
            @info[:media_thumbnail] = "http://mobth#{direct_url_suffix}"
          else
            @info[:media_api_id] = @info[:media_id]
          end
        else
          raise UnsupportedURI          
        end
        
        self
      end       
      
      def self.parsable?(uri)
        uri.host =~ /^([a-z0-9]*?[^(media)])\.photobucket\.com$/i
      end  
      
    end
  end
end
# http://gw0001.photobucket.com/groups/0001/F9P8EG7YR8/002new.jpg

# http://media.photobucket.com/image/searchterm/pbapi/file.jpg (search result)
# http://i244.photobucket.com/albums/gg17/pbapi/file.jpg (full view)
# http://media.photobucket.com/image/gg17/pbapi/?action=view&current=file.jpg (preview view)

# http://s244.photobucket.com/albums/gg17/pbapi/api-test/api-test-subalbum/?action=view&current=ThuOct15131605MDT2009.jpg (preview)
# http://i244.photobucket.com/albums/gg17/pbapi/api-test/api-test-subalbum/ThuOct15131605MDT2009.jpg (full view)

# http://i37.photobucket.com/albums/e87/hailiespence/shaun%20white/20060212104609990002.jpg
# http://media.photobucket.com/image/winter%20olympics/hailiespence/shaun%20white/20060212104609990002.jpg?o=12 (preview)

# http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/siamese_cat_.jpg
# http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg


# http://s434.photobucket.com/albums/qq63/atommy_polar/?action=view&current=Me.jpg&newest=1
# http://i434.photobucket.com/albums/qq63/atommy_polar/Me.jpg
# http://s434.photobucket.com/albums/qq63/atommy_polar/?action=view&current=Me.jpg

# http://pic.pbsrc.com/dev_help/WebHelpPublic/PhotobucketPublicHelp.htm -> Conventions -> URL Structures
#   http://pic.photobucket.com/dev_help/WebHelpPublic/Content/Getting%20Started/Conventions.htm
#   http://pic.pbsrc.com/dev_help/WebHelpPublic/Content/Getting%20Started/Web%20Authentication.htm
