module AutoMediaInfo
  module Transformer
  
    class Youtube
      def transform(url)
        url
      end
    
      def self.able_to_transform?(url)
        url =~ /www.youtube.com/im
      end
    
    end
  end
end