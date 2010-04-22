class Muri
  module Fetcher
    module Picasa

      private

      def self.included(base)
        base.class_eval do
          self::FETCHERS[PICASA_SERVICE_NAME] = "picasa_fetch"          
        end
      end

      def self.fetchable?
        Muri::Options.picasa_enabled == true
      end
      
      def picasa_fetch
        raise unless Muri::Fetcher::Picasa.fetchable?
        if self.picasa_photo?                   
          url = "http://picasaweb.google.com/data/feed/api/user/#{self.media_api_id}?v=2"
          doc = Muri.send(:fetch_xml, url)
          
          self.media_title            = REXML::XPath.first(doc, '//title').text
          self.media_description      = REXML::XPath.first(doc, '//subtitle').text
          self.media_keywords         = REXML::XPath.first(doc, '//media:keywords').text.split(", ")
          self.media_url              = REXML::XPath.first(doc, '//media:content').attributes["url"]          
          self.media_thumbnail        = REXML::XPath.each(doc, '//media:thumbnail').last.attributes["url"]          
          self.media_updated          = Time.parse(REXML::XPath.first(doc, '//updated').text, Time.now.utc)          
          true
        else
          false
        end
      rescue
        false          
      end
      
      #def picasa_nokogiri
        #doc = Nokogiri::XML(open("http://picasaweb.google.com/data/feed/api/user/#{self.media_api_id}?v=2"))
        #self.media_title          = doc.search("title").inner_text
        #self.media_description    = doc.search("subtitle").inner_text
        #self.media_keywords       = doc.xpath("//media:keywords").inner_text
        #self.media_url            = doc.xpath("//media:content").first["url"]
        #self.media_thumbnail      = doc.xpath("//media:thumbnail").last["url"]
        #self.media_updated        = Time.parse(doc.search('updated').inner_text, Time.now.utc) 
      #end
    end
  end
end
## Photo XML
#<?xml version='1.0' encoding='UTF-8'?>
#<feed xmlns='http://www.w3.org/2005/Atom' xmlns:exif='http://schemas.google.com/photos/exif/2007' xmlns:gphoto='http://schemas.google.com/photos/2007' xmlns:media='http://search.yahoo.com/mrss/' xmlns:openSearch='http://a9.com/-/spec/opensearchrss/1.0/'>
#<id>http://picasaweb.google.com/data/feed/api/user/bananastalktome/album/testforapi/photoid/5450524726782297346</id>
#<updated>2010-04-14T16:00:00.000Z</updated>
#<category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#photo'/>
#<title type='text'>IMGP1875.JPG</title>
#<subtitle type='text'/>
#<icon>http://lh4.ggpht.com/_IUTpexZO0m0/S6QnXGNXhQI/AAAAAAAAAFw/IufEKKW0gXM/s288/IMGP1875.JPG</icon>
#<link rel='http://schemas.google.com/g/2005#feed' type='application/atom+xml' href='http://picasaweb.google.com/data/feed/api/user/bananastalktome/albumid/5450524630931856065/photoid/5450524726782297346'/>
#<link rel='http://schemas.google.com/g/2005#post' type='application/atom+xml' href='http://picasaweb.google.com/data/feed/api/user/bananastalktome/albumid/5450524630931856065/photoid/5450524726782297346?tok=VN7Q1XMufsQ4dAhN69eUo3SzTao'/>
#<link rel='edit' type='application/atom+xml' href='http://picasaweb.google.com/data/entry/api/user/bananastalktome/albumid/5450524630931856065/photoid/5450524726782297346/1?tok=HodaOcewsY1k7hntPpuQ7RJJs5E'/>
#<link rel='alternate' type='text/html' href='http://picasaweb.google.com/lh/photo/E3zthhBaUveyfKtypyNY_g'/>
#<link rel='self' type='application/atom+xml' href='http://picasaweb.google.com/data/feed/api/user/bananastalktome/albumid/5450524630931856065/photoid/5450524726782297346?start-index=1&amp;max-results=500'/>
#<generator version='1.00' uri='http://picasaweb.google.com/'>Picasaweb</generator>
#<openSearch:totalResults>0</openSearch:totalResults>
#<openSearch:startIndex>1</openSearch:startIndex>
#<openSearch:itemsPerPage>500</openSearch:itemsPerPage>
#<gphoto:id>5450524726782297346</gphoto:id>
#<gphoto:version>1</gphoto:version>
#<gphoto:albumid>5450524630931856065</gphoto:albumid>
#<gphoto:access>public</gphoto:access>
#<gphoto:width>3008</gphoto:width>
#<gphoto:height>2000</gphoto:height>
#<gphoto:size>2901274</gphoto:size>
#<gphoto:client/><gphoto:checksum/>
#<gphoto:timestamp>1261233441000</gphoto:timestamp>
#<gphoto:imageVersion>92</gphoto:imageVersion>
#<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
#<gphoto:commentCount>0</gphoto:commentCount>
#<gphoto:license id='0' name='All Rights Reserved' url=''>ALL_RIGHTS_RESERVED</gphoto:license>
#<gphoto:viewCount>31</gphoto:viewCount>
#<exif:tags>
#  <exif:fstop>9.5</exif:fstop>
#  <exif:make>PENTAX Corporation </exif:make>
#  <exif:model>PENTAX K100D Super </exif:model>
#  <exif:exposure>0.004</exif:exposure>
#  <exif:flash>false</exif:flash>
#  <exif:focallength>35.0</exif:focallength>
#  <exif:iso>200</exif:iso>
#  <exif:time>1261233441000</exif:time>
#  <exif:imageUniqueID>b6f64812e02045105d7c6dc2285c2050</exif:imageUniqueID>
#</exif:tags>
#<media:group>
#  <media:content url='http://lh4.ggpht.com/_IUTpexZO0m0/S6QnXGNXhQI/AAAAAAAAAFw/IufEKKW0gXM/IMGP1875.JPG' height='1064' width='1600' type='image/jpeg' medium='image'/>
#  <media:credit>Billy</media:credit>
#  <media:description type='plain'/>
#  <media:keywords/>
#  <media:thumbnail url='http://lh4.ggpht.com/_IUTpexZO0m0/S6QnXGNXhQI/AAAAAAAAAFw/IufEKKW0gXM/s72/IMGP1875.JPG' height='48' width='72'/>
#  <media:thumbnail url='http://lh4.ggpht.com/_IUTpexZO0m0/S6QnXGNXhQI/AAAAAAAAAFw/IufEKKW0gXM/s144/IMGP1875.JPG' height='96' width='144'/>
#  <media:thumbnail url='http://lh4.ggpht.com/_IUTpexZO0m0/S6QnXGNXhQI/AAAAAAAAAFw/IufEKKW0gXM/s288/IMGP1875.JPG' height='192' width='288'/>
#  <media:title type='plain'>IMGP1875.JPG</media:title>
#</media:group>
#</feed>