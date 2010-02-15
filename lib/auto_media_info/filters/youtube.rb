module AutoMediaInfo
  module Transformer
  
    class Youtube
    
    
      def able_to_transform?(url)
        url =~ /www.youtube.com/im
      end
    
    end
  end
end