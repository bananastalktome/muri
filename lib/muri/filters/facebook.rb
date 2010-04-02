class Muri
  module Filter
    module Facebook

      private
      FACEBOOK_PHOTO = "photo"
      #FACEBOOK_VIDEO = "video"
      FACEBOOK_ALBUM = "album"
      REGEX_FACEBOOK_PHOTO = /^\/photo\.php$/i
      REGEX_FACEBOOK_ALBUM = /^\/album\.php$/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Facebook] = "facebook_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?facebook\.com$/i
      end

      def facebook_parse
        self.media_service = FACEBOOK_SERVICE_NAME #'Facebook'
        params = Muri.param_parse(self.uri.query)

        url_common = "http://www.facebook.com"

#         if self.uri.path =~ /^\/v\/([0-9]+)/
#           @info[:media_id] = $1
#           @info[:media_url] = "#{url_common}/v/#{@info[:media_id]}"
#
#           # Currently no API for video, but media_id is best guess value for such content
#           @info[:media_api_id] = @info[:media_id]
#           @info[:media_api_type] = FACEBOOK_VIDEO
        if ((self.uri.path =~ REGEX_FACEBOOK_PHOTO) &&
            params["pid"] =~ /^([0-9]+)$/ &&
            params["id"] =~ /^([0-9]+)$/ &&
            params["l"] =~ /^([0-9a-z]+)$/i)

          self.media_api_type = FACEBOOK_PHOTO
          self.media_id = params["pid"]
          media_creator = params["id"]
          share_key = params["l"]

          self.media_website = "#{url_common}/photo.php?pid=#{self.media_id}&l=#{share_key}&id=#{media_creator}"
        elsif ((self.uri.path =~ REGEX_FACEBOOK_ALBUM) &&
            params["aid"] =~ /^([0-9]+)$/ &&
            params["id"] =~ /^([0-9]+)$/ &&
            params["l"] =~ /^([0-9a-z]+)$/i)

          self.media_api_type = FACEBOOK_ALBUM
          self.media_id = params["aid"]
          media_creator = params["id"]
          share_key = params["l"]

          self.media_website = "#{url_common}/album.php?aid=#{self.media_id}&l=#{share_key}&id=#{media_creator}"
        else
          raise UnsupportedURI
        end

        # The media_api_id is the PID which can be searched for in the facebook photos/albums table
        self.media_api_id = (media_creator.to_i << 32) + self.media_id.to_i
      end
    end
  end
end
# http://www.facebook.com/album.php?aid=2131184&id=15201063&l=8917e51479
# http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063 (preview)
# database_pid = (USER_ID << 32) + PID
#   pid = photo id
#   id = user id
#   l = photo share key
# http://www.facebook.com/v/614695029223 (full) - deprecated
# http://www.facebook.com/album.php?aid=2149275&id=15201063&l=99900807c3
