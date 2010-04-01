class Muri
  module Filter
    module Picasa

      private
      PICASA_PHOTO = 'photo'
      
      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Picasa] = "picasa_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?picasaweb\.google\.com$/i
      end

      def picasa_parse
        self.media_service = PICASA_SERVICE_NAME
        url_common = "http://picasaweb.google.com"
        reencoded_url = URI.parse(URI.encode self.uri.to_s)
        
        if reencoded_url.path =~ /^\/(.[^\/]+)\/(.+)/i
          username = $1
          album_photoid = $2.split("%23")
          photoid = album_photoid.last
          album = album_photoid[0..-2].join("#")#in case other hash symbols exist
          self.media_id = photoid
          self.media_website = "#{url_common}/#{username}/#{album}##{photoid}"
          #self.media_url = "#{url_common}/show/large/#{self.media_id}"
          #self.media_thumbnail = "#{url_common}/show/thumb/#{self.media_id}"
          self.media_api_type = PICASA_PHOTO
        else
          raise UnsupportedURI
        end

        self.media_api_id = "user/#{username}/album/#{album}/photoid/#{photoid}"
      end
    end
  end
end
# http://picasaweb.google.com/bananastalktome/TestForAPI#5450524726782297346
# API Call: http://picasaweb.google.com/data/feed/api/user/bananastalktome/album/TestForAPI/photoid/5450524726782297346
# #=%23