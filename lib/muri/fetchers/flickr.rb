class Muri
  module Fetcher
    module Flickr

      private

      def self.included(base)
        base.class_eval do
          self::FETCHERS[FLICKR_SERVICE_NAME] = "flickr_fetch"
          def self.flickr_fetchable?
            Muri::Options.flickr_api_key
          end          
        end
      end
      
      def flickr_fetch
        raise unless Muri.flickr_fetchable?
        if self.flickr_photo?
          url = "http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=#{MuriOptions[:flickr][:api_key]}&photo_id=#{self.media_api_id}"
          doc = Muri.send(:fetch_xml, url)
          
          self.media_title            = REXML::XPath.first(doc, '//title').text
          self.media_description      = REXML::XPath.first(doc, '//description').text
          self.media_keywords         = REXML::XPath.each(doc, '//tags tag').collect{ |t| t.text }
          self.media_notes            = REXML::XPath.first(doc, '//notes').text
          self.media_posted           = Time.at(REXML::XPath.first(doc, '//dates').attributes["posted"].to_i)
          self.media_updated          = Time.at(REXML::XPath.first(doc, '//dates').attributes["lastupdate"].to_i)
          photo_element               = REXML::XPath.first(doc, '//photo')
          
          farm                        = photo_element.attributes['farm']
          server_id                   = photo_element.attributes['server']
          secret                      = photo_element.attributes['secret']
          
          url_prefix                  = "http://farm#{farm}.static.flickr.com/#{server_id}/#{self.media_api_id}_#{secret}"
          self.media_url              = "#{url_prefix}.jpg"
          self.media_thumbnail        = "#{url_prefix}_t.jpg"          
          true
        else
          false
        end
      rescue
        false          
      end
      
      #def flickr_nokogiri
        #doc = Nokogiri::XML(open("http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=#{MuriOptions[:flickr][:api_key]}&photo_id=#{self.media_api_id}"))
        #self.media_title          = doc.search("title").inner_text
        #self.media_description    = doc.search("description").inner_text
        #self.media_keywords       = doc.search("tags tag").collect{ |t| t.inner_text }
        #self.media_notes          = doc.search("notes").inner_text
        #photo_element             = doc.search("photo").first
        #
        #farm                      = photo_element[:farm]
        #server_id                 = photo_element[:server]
        #media_secret              = photo_element[:secret]
        #
        #url_prefix                = "http://farm#{farm}.static.flickr.com/#{server_id}/#{self.media_api_id}_#{media_secret}"
        #self.media_url            = "#{url_prefix}.jpg"
        #self.media_thumbnail      = "#{url_prefix}_t.jpg"
        #self.media_posted         = Time.at(doc.search('dates').first[:posted].to_i)
        #self.media_updated        = Time.at(doc.search('dates').first[:lastupdate].to_i)
        #                            #Time.parse(doc.search('dates').first[:lastupdate], Time.now.utc)
      #end
    end
  end
end
## Photo XML
#<rsp stat="ok">
#  <photo id="2087648809" secret="d60161e8a9" server="2209" farm="3" dateuploaded="1196831728" isfavorite="0" license="0" rotation="0" views="1" media="photo">
#  <owner nsid="21541244@N02" username="bananastalktome" realname="" location=""/>
#  <title>DSC01364</title>
#  <description/>
#  <visibility ispublic="1" isfriend="0" isfamily="0"/>
#  <dates posted="1196831728" taken="2007-12-02 22:20:04" takengranularity="0" lastupdate="1196877368"/>
#  <editability cancomment="0" canaddmeta="0"/>
#  <usage candownload="1" canblog="0" canprint="0" canshare="0"/>
#  <comments>0</comments>
#  <notes/>
#  <tags>
#    <tag id="455705-3430562441-124178" author="21541244@N02" raw="Bletchley Park" machine_tag="0">bletchleypark</tag>
#  </tags>
#  <urls>
#    <url type="photopage">
#      http://www.flickr.com/photos/bananastalktome/2087648809/
#    </url>
#  </urls>
#  </photo>
#</rsp>
