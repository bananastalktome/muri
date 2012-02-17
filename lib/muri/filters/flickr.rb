class Muri
  module Filter
    module Flickr

      private
      FLICKR_MEDIA = "media"
      FLICKR_SET = "set"

      REGEX_FLICKR_MEDIA_OR_SET = /^\/photos\/([a-z0-9\-\_\@]+?)\/(sets\/)?([0-9]+)/i
      REGEX_FLICKR_STATIC_MEDIA = /^farm([1-3])\.static.?flickr.com\/([0-9]+?)\/([0-9]+?)\_([a-z0-9]+?)((?:\_[a-z]){1,2}){0,1}\.([a-z]+)/i
      REGEX_FLICKR_SHORTURL = /^flic\.kr\/p\/([a-z0-9]+)/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Flickr] = "flickr_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?(flic\.kr|(farm[0-9]\.static\.?|)(flickr)\.com)/i
      end

      def flickr_parse
        self.media_service = FLICKR_SERVICE_NAME #'Flickr'

        if self.uri.path =~ REGEX_FLICKR_MEDIA_OR_SET
          media_creator = $1
          self.media_id = $3
          self.media_api_type = $2.nil? ? FLICKR_MEDIA : FLICKR_SET
        elsif (self.uri.host + self.uri.path) =~ REGEX_FLICKR_STATIC_MEDIA
          farm = $1
          server_id = $2
          self.media_id = $3
          self.media_api_type = FLICKR_MEDIA
          media_secret = $4
          url_prefix = "http://farm#{farm}.staticflickr.com/#{server_id}/#{self.media_id}_#{media_secret}"
          self.media_url = "#{url_prefix}.jpg"
          self.media_thumbnail = "#{url_prefix}_t.jpg"
        elsif (self.uri.host + self.uri.path) =~ REGEX_FLICKR_SHORTURL
          self.media_id = Filter::Flickr.decode58($1)
          self.media_api_type = FLICKR_MEDIA
        else
          raise UnsupportedURI
        end

        self.media_api_id = self.media_id
        if self.flickr_media?
          self.media_website = "http://flic.kr/p/" + Filter::Flickr.encode58(self.media_id.to_i)
        elsif self.flickr_set?
          self.media_website = "http://www.flickr.com/photos/#{media_creator}/sets/#{self.media_id}" # appending /show takes direct to image through redirect
        end
      end
      
      # Ported from PHP.
      def self.decode58(str)
        decoded = 0
        multi = 1
        alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
        while str.length > 0
          digit = str[(str.length - 1),1]
          decoded += multi * alphabet.index(digit)
          multi = multi * alphabet.length
          str.chop!
        end
        decoded
      end
    
      # Ported from PHP.
      def self.encode58(str)
        alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
        base_count = alphabet.length
        encoded = ''
        while str >= base_count
          div = str / base_count
          mod = (str-(base_count * div))
          encoded = alphabet[mod,1] + encoded
          str = div
        end
        encoded = (alphabet[str,1] + encoded) if str
        encoded
      end
    end
  end
end
