class Muri
  module Fetcher
    module Vimeo

      private
  
      def self.included(base)
        base.class_eval do
          self::FETCHERS[VIMEO_SERVICE_NAME] = "vimeo_fetch"
        end
      end
      
      def vimeo_fetch
        doc = Nokogiri::XML(open("http://vimeo.com/api/v2/video/#{self.media_api_id}"))
        self.media_title            = doc.search("title").inner_text
        self.media_description      = doc.search("description").inner_text
        self.media_keywords         = doc.search("tags").inner_text.split(", ")
        self.media_duration         = doc.xpath("duration").inner_text.to_i       
        self.media_date             = Time.parse(doc.search("upload_date").inner_text, Time.now.utc)
        self.media_thumbnail        = doc.search("thumbnail_small").inner_text
        self.media_thumbnail_large  = doc.search("thumbnail_large").inner_text        
      end
      
    end
  end
end

