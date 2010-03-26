class Muri
  module Filter
    module Flickr

      protected
      FLICKR_PHOTO = "photo"
      FLICKR_SET = "set"

      REGEX_FLICKR_PHOTO_OR_SET = /^\/photos\/([a-z0-9\-\_\@]+?)\/(sets\/)?([0-9]+)/i
      REGEX_FLICKR_STATIC_PHOTO = /^farm([1-3])\.static.flickr.com\/([0-9]+?)\/([0-9]+?)\_([a-z0-9]+?)(\_[a-z]){0,1}\.([a-z]+)/i
      REGEX_FLICKR_SHORTURL = /^flic\.kr\/p\/([a-z0-9]+)/i

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Flickr] = "flickr_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^(www\.)?(flic\.kr|(farm[0-9]\.static\.|)(flickr)\.com)/i
      end

      def flickr_parse
        self.media_service = 'Flickr'

        if self.url.path =~ REGEX_FLICKR_PHOTO_OR_SET
          media_creator = $1
          self.media_id = $3
          self.media_api_type = $2.nil? ? FLICKR_PHOTO : FLICKR_SET
        elsif (self.url.host + self.url.path) =~ REGEX_FLICKR_STATIC_PHOTO
          farm = $1
          server_id = $2
          self.media_id = $3
          self.media_api_type = FLICKR_PHOTO
          media_secret = $4
          url_prefix = "http://farm#{farm}.static.flickr.com/#{server_id}/#{self.media_id}_#{media_secret}"
          self.media_url = "#{url_prefix}.jpg"
          self.media_thumbnail = "#{url_prefix}_t.jpg"
        elsif (self.url.host + self.url.path) =~ REGEX_FLICKR_SHORTURL
          self.media_id = self.class.decode58($1)
          self.media_api_type = FLICKR_PHOTO
        else
          raise UnsupportedURI
        end

        self.media_api_id = self.media_id
        if self.media_api_type == FLICKR_PHOTO
          self.media_website = "http://flic.kr/p/" + self.class.encode58(self.media_id.to_i)
        elsif self.media_api_type == FLICKR_SET
          self.media_website = "http://www.flickr.com/photos/#{media_creator}/sets/#{self.media_id}"#/show takes direct
        end
      end
    end
  end
end
#           if !$5.nil?
#             @info[:media_size] = case $5.downcase
#               when '_s' then 'square'
#               when '_t' then 'thumbnail'
#               when '_m' then 'small'
#               when '_b' then 'large'
#               when '_o' then 'original'
#               else 'medium'
#             end
#           end
#           @info[:content_type] = $6
# http://www.flickr.com/photos/bananastalktome/2088436532/ (preview)
# http://flic.kr/p/4bxMqq (preview)
# http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg (direct)
#   farm-id: 3
#   server-id: 2178
#   photo-id: 2088436532
#   secret: ee07b4474e
#   size: m
# * add _d before .jpg in url to create a download URL
# http://www.flickr.com/photos/bananastalktome/sets/72157623467777820/ (set preview)
