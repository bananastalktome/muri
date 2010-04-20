class Muri
  module Fetcher
    module Vimeo

      private
  
      def self.included(base)
        base.class_eval do
          self::FETCHERS[VIMEO_SERVICE_NAME] = "vimeo_fetch"
          def self.vimeo_fetchable?
            Muri::Options.vimeo_enabled == true
          end              
        end
      end
      
      def vimeo_fetch
        raise unless Muri.vimeo_fetchable?
        if self.vimeo_video?          
          url = "http://vimeo.com/api/v2/video/#{self.media_api_id}.xml"
          doc = Muri.send(:fetch_xml, url)
          
          self.media_title            = REXML::XPath.first(doc, '//title').text
          self.media_description      = REXML::XPath.first(doc, '//description').text
          self.media_keywords         = REXML::XPath.first(doc, '//tags').text.split(", ")
          self.media_duration         = REXML::XPath.first(doc, '//duration').text.to_i
          self.media_posted           = Time.parse(REXML::XPath.first(doc, '//upload_date').text, Time.now.utc)
          self.media_thumbnail        = REXML::XPath.first(doc, 'thumbnail_small').text
          self.media_thumbnail_large  = REXML::XPath.first(doc, 'thumbnail_large').text
          true
        else
          false
        end
      rescue
        false
      end
      
      #def vimeo_nokogiri
        #doc = Nokogiri::XML(open("http://vimeo.com/api/v2/video/#{self.media_api_id}.xml"))
        #self.media_title            = doc.search("title").inner_text
        #self.media_description      = doc.search("description").inner_text
        #self.media_keywords         = doc.search("tags").inner_text.split(", ")
        #self.media_duration         = doc.xpath("duration").inner_text.to_i
        #self.media_posted           = Time.parse(doc.search("upload_date").inner_text, Time.now.utc)
        #self.media_thumbnail        = doc.search("thumbnail_small").inner_text
        #self.media_thumbnail_large  = doc.search("thumbnail_large").inner_text        
      #end
    end
  end
end

