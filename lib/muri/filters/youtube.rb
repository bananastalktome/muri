require 'cgi'
class Muri
  module Filter
    module Youtube

      private
      YOUTUBE_VIDEO = "video"
      YOUTUBE_PLAYLIST = "playlist"
      REGEX_YOUTUBE_VIDEO_WATCH = /^\/watch$/i
      REGEX_YOUTUBE_VIDEO_DIRECT = /\/v\/([a-z0-9\-\_]+)/i
      REGEX_YOUTUBE_PLAYLIST_WATCH = /^\/view\_play\_list$/i
      REGEX_YOUTUBE_PLAYLIST_DIRECT = /^\/p\/([a-z0-9\-\_]+)/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Youtube] = "youtube_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?youtube\.com$/i
      end

      def youtube_parse
        self.media_service = 'Youtube'
        url_common = "http://www.youtube.com"
        params = self.url.query.nil? ? {} : self.class.param_parse(self.url.query)

        if (self.url.path =~ REGEX_YOUTUBE_VIDEO_WATCH) && params['v']
          self.media_id = params['v']
          self.media_api_type = YOUTUBE_VIDEO
        elsif (self.url.path =~ REGEX_YOUTUBE_VIDEO_DIRECT)
          self.media_id = $1
          self.media_api_type = YOUTUBE_VIDEO
        elsif (self.url.path =~ REGEX_YOUTUBE_PLAYLIST_DIRECT)
          self.media_id = $1
          self.media_api_type = YOUTUBE_PLAYLIST
        elsif (self.url.path =~ REGEX_YOUTUBE_PLAYLIST_WATCH) && (params['p'])
          self.media_id = params['p']
          self.media_api_type = YOUTUBE_PLAYLIST
        else
          raise UnsupportedURI
        end

        self.media_api_id = self.media_id
        if self.youtube_video?
          self.media_website = "#{url_common}/watch?v=#{self.media_id}"
          self.media_url = "#{url_common}/v/#{self.media_id}"
          self.media_thumbnail = "http://i.ytimg.com/vi/#{self.media_id}/default.jpg"
        elsif self.youtube_playlist?
          self.media_website = "#{url_common}/view_play_list?p=#{self.media_id}"
          self.media_url = "#{url_common}/p/#{self.media_id}"
        end
      end
    end
  end
end
# http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1& (direct)
# http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM (preview)

# PLAYLISTS
# http://www.youtube.com/p/57633EC69B4A10A2&hl=en_US&fs=1 (direct)
# http://www.youtube.com/view_play_list?p=57633EC69B4A10A2 (preview)
