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
        
        if (self.uri.path =~ /^\/(.[^\/]+)\/(.[^\/]+)/i) && !self.uri.fragment.nil?
          username = $1
          album = $2 #album_photoid[0..-2].join("#") #in case other hash symbols exist
          
          album_photoid = self.uri.fragment.split("#")
          photoid = album_photoid.last
          self.media_id = photoid
          self.media_website = "#{url_common}/#{username}/#{album}##{photoid}"
          self.media_api_type = PICASA_PHOTO
          self.media_api_id = "#{username}/album/#{album}/photoid/#{photoid}"          
        else
          raise UnsupportedURI
        end

      end
    end
  end
end
# http://picasaweb.google.com/bananastalktome/TestForAPI#5450524726782297346
# API Call: http://picasaweb.google.com/data/feed/api/user/bananastalktome/album/TestForAPI/photoid/5450524726782297346
# #=%23
# http://picasaweb.google.com/data/entry/api/user/bananastalktome/photoid/5450524726782297346