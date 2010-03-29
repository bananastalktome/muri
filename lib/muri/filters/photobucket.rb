class Muri
  module Filter
    module Photobucket

      private
      PHOTOBUCKET_MEDIA = "media"
      PHOTOBUCKET_ALBUM = "album"
      PHOTOBUCKET_GROUP_ALBUM = "group_album"

      REGEX_PHOTOBUCKET_IMAGE = /^\/albums\/(.+?)\/(?:(.*)\/)*(.+?)\.(.+?)$/i
      REGEX_PHOTOBUCKET_ALBUM_OR_IMAGE = /^\/albums\/(.+?)\/(.[^\.]*?)\/?$/i
      REGEX_PHOTOBUCKET_GROUP_IMAGE = /^\/groups\/(.+?)\/(.+?)\/(.+?)\.(.+)$/i
      REGEX_PHOTOBUCKET_GROUP_ALBUM_OR_IMAGE = /^\/groups\/(\w+?)\/(\w+?)\/?$/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Photobucket] = "photobucket_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^([a-z0-9]*?[^(media)])\.photobucket\.com$/i
      end
      
      def photobucket_parse
        self.media_service = PHOTOBUCKET_SERVICE_NAME #'Photobucket'

        self.uri.host =~ /^([a-z0-9]*?[^(media)])\.photobucket\.com$/i
        self.media_server_id = $1.gsub(/([a-z]*)/i,"")
        params = Muri.param_parse(self.uri.query)

        if self.uri.path =~ REGEX_PHOTOBUCKET_IMAGE
          self.media_id = $3
          self.media_content_type = $4
          photobucket_set_image_common($1, $2)
        elsif self.uri.path =~ REGEX_PHOTOBUCKET_ALBUM_OR_IMAGE
          pb_id = $1
          album = $2
          url_common = "#{self.media_server_id}.photobucket.com/albums/#{pb_id}/#{album}"
          if (params["action"] =~ /^(view)$/i && params["current"] =~ /^(.+)\.([a-z0-9]+)$/i)
            filename = params["current"].split(".")
            self.media_id = filename.first
            self.media_content_type = filename.last
            photobucket_set_image_common(pb_id, album)
          else
            self.media_id = "#{album}"
            self.media_api_type = PHOTOBUCKET_ALBUM
            self.media_website = "http://s#{url_common}/"
          end
        elsif self.uri.path =~ REGEX_PHOTOBUCKET_GROUP_IMAGE
          self.media_id = $3
          self.media_content_type = $4
          photobucket_set_group_image_common($1, $2)
        elsif self.uri.path =~ REGEX_PHOTOBUCKET_GROUP_ALBUM_OR_IMAGE
          group = $1
          hash_value = $2
          url_common = "#{self.media_server_id}.photobucket.com/groups/#{group}/#{hash_value}"
          if (params["action"] =~ /^(view)$/i && params["current"] =~ /^(.+)\.([a-z0-9]+)$/i)
            filename = params["current"].split(".")
            self.media_id = filename.first
            self.media_content_type = filename.last
            photobucket_set_group_image_common(group, hash_value)
          else
            self.media_id = hash_value
            self.media_website = "http://gs#{url_common}/"
            self.media_api_type = PHOTOBUCKET_GROUP_ALBUM
          end
        else
          raise UnsupportedURI
        end

        self.media_api_id = self.is_photobucket_media? ? self.media_url : self.media_id
      end

      def photobucket_set_image_common(pb_id, album)
        url_common = "#{self.media_server_id}.photobucket.com/albums/#{pb_id}/#{album}/"
        url_suffix = "#{url_common}#{self.media_id}.#{self.media_content_type}"
        self.media_api_type = PHOTOBUCKET_MEDIA
        self.media_url = "http://i" + url_suffix
        self.media_website = "http://s#{url_common}?action=view&current=#{self.media_id}.#{self.media_content_type}"
        self.media_thumbnail = "http://mobth#{url_suffix}"
      end

      def photobucket_set_group_image_common(group, hash_value)
        url_common = "#{self.media_server_id}.photobucket.com/groups/#{group}/#{hash_value}"
        url_suffix = "#{url_common}/#{self.media_id}.#{self.media_content_type}"
        self.media_api_type = PHOTOBUCKET_MEDIA
        self.media_url = "http://gi" + url_suffix
        self.media_website = "http://gs#{url_common}/?action=view&current=#{self.media_id}.#{self.media_content_type}"
        self.media_thumbnail = "http://mobth#{url_suffix}"
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
