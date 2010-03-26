class Muri
  module Filter
    module Twitpic

      private
      TWITPIC_PHOTO = 'photo'

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Twitpic] = "twitpic_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^twitpic\.com$/i
      end

      def twitpic_parse
        self.media_service = 'Twitpic'
        url_common = "http://twitpic.com"

        if self.url.path =~ /^\/([a-z0-9]+)/i
          self.media_id = $1
          self.media_website = "#{url_common}/#{self.media_id}"
          self.media_url = "#{url_common}/show/large/#{self.media_id}"
          self.media_thumbnail = "#{url_common}/show/thumb/#{self.media_id}"
          self.media_api_type = TWITPIC_PHOTO
        else
          raise UnsupportedURI
        end

        # Twitpic does not have an API to pull photo info. Media ID is best guess
        self.media_api_id = self.media_id
      end
    end
  end
end
# http://twitpic.com/17d7th
# http://twitpic.com/show/large/17d7th
# http://twitpic.com/show/thumb/17d7th

# http://twitpic.com/api.do
