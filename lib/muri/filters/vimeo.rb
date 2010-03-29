class Muri
  module Filter
    module Vimeo

      private
      VIMEO_VIDEO = "video"
      VIMEO_ALBUM = "album"
      
      REGEX_VIMEO_VIDEO_OR_ALBUM = /^\/(album\/)?([0-9]+)\/?$/i
      REGEX_VIMEO_GROUP_VIDEO = /^\/groups\/([0-9a-z\@\-\_]+)\/videos\/([0-9]+)\/?$/i
      REGEX_VIMEO_SWF_VIDEO = /^\/moogaloop\.swf$/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Vimeo] = "vimeo_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?vimeo\.com$/i
      end

      def vimeo_parse
        self.media_service = VIMEO_SERVICE_NAME #'Vimeo'
        params = Muri.param_parse(self.uri.query)

        if self.uri.path =~ REGEX_VIMEO_VIDEO_OR_ALBUM
          self.media_id = $2
          self.media_api_type = $1.nil? ? VIMEO_VIDEO : VIMEO_ALBUM
        elsif self.uri.path =~ REGEX_VIMEO_GROUP_VIDEO
          self.media_id = $2
          self.media_api_type = VIMEO_VIDEO
        elsif ((self.uri.path =~ REGEX_VIMEO_SWF_VIDEO) && (params["clip_id"] =~ /^([0-9]+)$/))
          self.media_id = params["clip_id"]
          self.media_api_type = VIMEO_VIDEO
        else
          raise UnsupportedURI
        end

        self.media_api_id = self.media_id
        self.media_website = Filter::Vimeo.vimeo_media_website self #:api_type => self.media_api_type, :id => self.media_id
        if self.is_vimeo_video?
          self.media_url = Filter::Vimeo.vimeo_media_url self #:id => self.media_id
        end
      end

      def self.vimeo_media_url(obj)
        "http://vimeo.com/moogaloop.swf?clip_id=#{obj.media_id}&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1"
      end

      def self.vimeo_media_website(obj)
        str = "http://vimeo.com/"
        str += "album/" if obj.media_api_type == VIMEO_ALBUM
        str += obj.media_id
      end
    end
  end
end
# http://www.vimeo.com/groups/beyondthestill/videos/9394829
# http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1"
# http://vimeo.com/7312128
# http://vimeo.com/album/89702
