class MURI
  module Filter
    module Flickr

      def self.included(base)
        base.class_eval do
          self::PARSERS["www.flickr.com"] = "flickr_parse"
          self::PARSERS["farm3.static.flickr.com"] = "flickr_parse"
          self::PARSERS["farm2.static.flickr.com"] = "flickr_parse"
          self::PARSERS["farm1.static.flickr.com"] = "flickr_parse"
          self::PARSERS["flic.kr"] = "flickr_parse"
        end
      end
      
      def flickr_parse
        @info[:service] = 'Flickr'
        
        if @url.path =~ /^\/photos\/([a-zA-Z0-9\@]*?)\/[^(?:sets)]([0-9]*)/i
          @info[:media_creator] = $1
          @info[:media_id] = $2
        elsif (@url.host + @url.path) =~ /^farm([1-3])\.static.flickr.com\/([0-9]*?)\/([0-9]*?)\_([a-zA-Z0-9]*?)(\_[a-zA-Z]){0,1}\.([a-zA-Z]*)/i
          @info[:media_id] = $3
          if !$5.nil?
            @info[:media_size] = case $5.downcase
              when '_s' then 'small'
              when '_t' then 'thumbnail'
              when '_m' then 'medium'
              when '_b' then 'large'
              else nil
            end
          end
          @info[:content_type] = $6.downcase
        elsif (@url.host + @url.path) =~ /^flic\.kr\/p\/([a-zA-Z0-9]*)/i
          @info[:media_id] = self.decode58($1)
        end
        
        if self.parsed?
          @info[:media_url] = "http://flic.kr/p/" + self.encode58(@info[:media_id].to_i)
        end
        
        self
      end
      
      def decode58(str)
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

      def encode58(str)
        alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
        base_count = alphabet.length
        encoded = ''
        while str >= base_count
          div = str / base_count
          mod = (str-(base_count * div.to_i))
          encoded = alphabet[mod,1] + encoded
          str = div.to_i
        end
        encoded = alphabet[str,1] + encoded if str
        encoded
      end    
      
    end
  end
end
# http://www.flickr.com/photos/bananastalktome/2088436532/
# http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg
#   farm-id: 3
#   server-id: 2178
#   photo-id: 2088436532
#   secret: ee07b4474e
#   size: m
# * add _d before .jpg in url to create a download URL