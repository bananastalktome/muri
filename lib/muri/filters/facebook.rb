class Muri
  module Filter
    module Facebook

      private
      FACEBOOK_PHOTO = "photo"
      FACEBOOK_VIDEO = "video"
      
      #FACEBOOK_ALBUM = "album"
      REGEX_FACEBOOK_PHOTO = /\/photo\.php/i
      REGEX_FACEBOOK_VIDEO = /\/video\/video\.php/i
      #REGEX_FACEBOOK_ALBUM = /^\/album\.php$/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Facebook] = "facebook_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?facebook\.com$/i
      end

      def facebook_parse
        self.media_service = FACEBOOK_SERVICE_NAME #'facebook'

        url_string = self.uri.fragment.nil? ? (self.uri.path.to_s + "?" + self.uri.query.to_s) : self.uri.fragment

        url_common = "http://www.facebook.com"

        if (url_string =~ REGEX_FACEBOOK_VIDEO && (v = url_string.gsub(/\A.*?v=(\d+)(&.*|\Z)/i, '\1')))
          
          self.media_api_type = FACEBOOK_VIDEO
          self.media_id = v
          self.media_api_id = v
          self.media_website = "#{url_common}/video/video.php?v=#{self.media_id}"
        elsif (url_string =~ REGEX_FACEBOOK_PHOTO &&
          (pid = url_string.gsub(/\A.*?pid=(\d+)(&.*|\Z)/i, '\1')) &&
          (uid = url_string.gsub(/\A.*?[^p]id=(\d+)(&.*|\Z)/i, '\1')))
          
          self.media_api_type = FACEBOOK_PHOTO
          self.media_id = pid
          media_creator = uid
          
          fql_id = ((media_creator.to_i << 32) + self.media_id.to_i).to_s
          
          self.media_api_id = fql_id
          
          #ugh, ugly, I hate facebook. FQL id's may stop working soon, so this may become media_api_id again later.
          self.media_api_ids = { :pid => pid, :uid => media_creator, :fql_id => fql_id }

          self.media_website = "#{url_common}/photo.php?pid=#{self.media_id}&id=#{media_creator}"
#         elsif ((self.uri.path =~ REGEX_FACEBOOK_ALBUM) &&
#             params["aid"] =~ /^([0-9]+)$/ &&
#             params["id"] =~ /^([0-9]+)$/ &&
#             params["l"] =~ /^([0-9a-z]+)$/i)
# 
#           self.media_api_type = FACEBOOK_ALBUM
#           self.media_id = params["aid"]
#           media_creator = params["id"]
#           share_key = params["l"]
# 
#           self.media_website = "#{url_common}/album.php?aid=#{self.media_id}&l=#{share_key}&id=#{media_creator}"
        else
          raise UnsupportedURI
        end
      end
    end
  end
end