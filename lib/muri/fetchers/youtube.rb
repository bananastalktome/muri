class Muri
  module Fetcher
    module Youtube

      private
      
      def self.included(base)
        base.class_eval do
          self::FETCHERS[YOUTUBE_SERVICE_NAME] = "youtube_fetch"
        end
      end
      
      def youtube_fetch
        if self.youtube_video?
          doc = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/videos/#{self.media_api_id}"))
          self.media_title            = doc.xpath("//media:title").inner_text
          self.media_description      = doc.xpath("//media:description").inner_text
          self.media_keywords         = doc.xpath("//media:keywords").inner_text.split(", ")
          self.media_duration         = doc.xpath("//yt:duration").first[:seconds].to_i
          self.media_date             = Time.parse(doc.search("published").inner_text, Time.now.utc)
          self.media_updated          = Time.parse(doc.search('updated').inner_text, Time.now.utc)
        end
      end
      
    end
  end
end
## Video XML
#<?xml version='1.0' encoding='UTF-8'?><entry xmlns='http://www.w3.org/2005/Atom' xmlns:media='http://search.yahoo.com/mrss/' xmlns:gd='http://schemas.google.com/g/2005' xmlns:yt='http://gdata.youtube.com/schemas/2007'><id>http://gdata.youtube.com/feeds/api/videos/TcI8fYKH3Ik</id><published>2009-02-12T18:48:01.000Z</published><updated>2010-04-10T22:50:03.000Z</updated><category scheme='http://schemas.google.com/g/2005#kind' term='http://gdata.youtube.com/schemas/2007#video'/><category scheme='http://gdata.youtube.com/schemas/2007/categories.cat' term='Entertainment' label='Entertainment'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Darius Goes West'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Duchenne Muscular Dystrophy'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='DMD'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Pimp my wheelchair'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='pimp my ride'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='MTV'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='documentary'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='trailer'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Darius Weems'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Logan Smalley'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Dogooder'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='Dogooder awards'/><category scheme='http://gdata.youtube.com/schemas/2007/keywords.cat' term='nonprofit video'/><title type='text'>Darius Goes West - "Pimp My Wheelchair"</title><content type='text'>Educators click here to claim your free DVD: http://www.goslabi.org/freedvd  
#
#If you aren't a teacher, please tell a teacher about this opportunity. Thanks!</content><link rel='alternate' type='text/html' href='http://www.youtube.com/watch?v=TcI8fYKH3Ik&amp;feature=youtube_gdata'/><link rel='http://gdata.youtube.com/schemas/2007#video.responses' type='application/atom+xml' href='http://gdata.youtube.com/feeds/api/videos/TcI8fYKH3Ik/responses'/><link rel='http://gdata.youtube.com/schemas/2007#video.related' type='application/atom+xml' href='http://gdata.youtube.com/feeds/api/videos/TcI8fYKH3Ik/related'/><link rel='self' type='application/atom+xml' href='http://gdata.youtube.com/feeds/api/videos/TcI8fYKH3Ik'/><author><name>dariusgoeswest</name><uri>http://gdata.youtube.com/feeds/api/users/dariusgoeswest</uri></author><gd:comments><gd:feedLink href='http://gdata.youtube.com/feeds/api/videos/TcI8fYKH3Ik/comments' countHint='224'/></gd:comments><media:group><media:category label='Entertainment' scheme='http://gdata.youtube.com/schemas/2007/categories.cat'>Entertainment</media:category><media:content url='http://www.youtube.com/v/TcI8fYKH3Ik?f=videos&amp;app=youtube_gdata' type='application/x-shockwave-flash' medium='video' isDefault='true' expression='full' duration='113' yt:format='5'/><media:content url='rtsp://v4.cache7.c.youtube.com/CiILENy73wIaGQmJ3IeCfTzCTRMYDSANFEgGUgZ2aWRlb3MM/0/0/0/video.3gp' type='video/3gpp' medium='video' expression='full' duration='113' yt:format='1'/><media:content url='rtsp://v6.cache5.c.youtube.com/CiILENy73wIaGQmJ3IeCfTzCTRMYESARFEgGUgZ2aWRlb3MM/0/0/0/video.3gp' type='video/3gpp' medium='video' expression='full' duration='113' yt:format='6'/><media:description type='plain'>Educators click here to claim your free DVD: http://www.goslabi.org/freedvd  
#
#If you aren't a teacher, please tell a teacher about this opportunity. Thanks!</media:description><media:keywords>Darius Goes West, Duchenne Muscular Dystrophy, DMD, Pimp my wheelchair, pimp my ride, MTV, documentary, trailer, Darius Weems, Logan Smalley, Dogooder, Dogooder awards, nonprofit video</media:keywords><media:player url='http://www.youtube.com/watch?v=TcI8fYKH3Ik&amp;feature=youtube_gdata'/><media:thumbnail url='http://i.ytimg.com/vi/TcI8fYKH3Ik/2.jpg' height='90' width='120' time='00:00:56.500'/><media:thumbnail url='http://i.ytimg.com/vi/TcI8fYKH3Ik/1.jpg' height='90' width='120' time='00:00:28.250'/><media:thumbnail url='http://i.ytimg.com/vi/TcI8fYKH3Ik/3.jpg' height='90' width='120' time='00:01:24.750'/><media:thumbnail url='http://i.ytimg.com/vi/TcI8fYKH3Ik/0.jpg' height='240' width='320' time='00:00:56.500'/><media:title type='plain'>Darius Goes West - "Pimp My Wheelchair"</media:title><yt:duration seconds='113'/></media:group><gd:rating average='4.732143' max='5' min='1' numRaters='224' rel='http://schemas.google.com/g/2005#overall'/><yt:statistics favoriteCount='98' viewCount='41141'/></entry>
