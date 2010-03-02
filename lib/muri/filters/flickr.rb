class Muri
  module Filter
    module Flickr

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Flickr] = "flickr_parse"
        end
      end
      
      def flickr_parse
        @info[:service] = 'Flickr'
        
        if @url.path =~ /^\/photos\/([a-z0-9\@]*?)\/([^(?:sets)][0-9]*)/i
          #@info[:media_creator] = $1
          @info[:media_id] = $2
        elsif (@url.host + @url.path) =~ /^farm([1-3])\.static.flickr.com\/([0-9]*?)\/([0-9]*?)\_([a-z0-9]*?)(\_[a-z]){0,1}\.([a-z]*)/i
          farm = $1
          server_id = $2
          @info[:media_id] = $3
          media_secret = $4
#           if !$5.nil?
#             @info[:media_size] = case $5.downcase
#               when '_s' then 'small'
#               when '_t' then 'thumbnail'
#               when '_m' then 'medium'
#               when '_b' then 'large'
#               else nil
#             end
#           end
#           @info[:content_type] = $6
            @info[:media_thumbnail] = "http://farm#{farm}.static.flickr.com/#{server_id}/#{@info[:media_id]}_#{media_secret}_t.jpg"
        elsif (@url.host + @url.path) =~ /^flic\.kr\/p\/([a-z0-9]*)/i
          @info[:media_id] = self.class.decode58($1)
        end
        
        if self.parsed?
          @info[:media_api_id] = @info[:media_id]
          @info[:website] = "http://flic.kr/p/" + self.class.encode58(@info[:media_id].to_i)
        else
          raise UnsupportedURI          
        end
        
        self
      end
      
      def self.parsable?(uri)
        uri.host =~ /^(www\.|)(flic\.kr|(farm[0-9]\.static\.|)(flickr)\.com)/i
      end  
  
      
    end
  end
end
# http://www.flickr.com/photos/bananastalktome/2088436532/ (preview)
# http://flic.kr/p/4bxMqq (preview)
# http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg (direct)
#   farm-id: 3
#   server-id: 2178
#   photo-id: 2088436532
#   secret: ee07b4474e
#   size: m
# * add _d before .jpg in url to create a download URL