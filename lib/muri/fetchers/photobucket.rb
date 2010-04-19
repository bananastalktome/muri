require 'digest'
require 'openssl'
require 'base64'
class Muri
  module Fetcher
    module Photobucket

      private

      def self.included(base)
        base.class_eval do
          self::FETCHERS[PHOTOBUCKET_SERVICE_NAME] = "photobucket_fetch"
          def self.photobucket_fetchable?
            #MuriOptions.include?(:photobucket) && MuriOptions[:photobucket].include?(:api_key)
            Muri::Options.photobucket_api_key && Muri::Options.photobucket_secret
          end
        end
      end
      
      def photobucket_fetch
        raise unless Muri.photobucket_fetchable?
        if self.photobucket_media?
          arg = CGI::escape(self.media_api_id)
          api_url = "http://api.photobucket.com/media/#{arg}"

          url = Muri::Fetcher::Photobucket.media_api_request(api_url)
          pp url
          doc = Muri.send(:fetch_xml, url)

          self.media_title            = REXML::XPath.first(doc, '//title').text
          self.media_description      = REXML::XPath.first(doc, '//description').text
          self.media_keywords         = REXML::XPath.each(doc, '//tag').collect{ |t| t.attributes["tag"] }
          self.media_thumbnail        = REXML::XPath.each(doc, '//thumb').text
          self.media_posted           = Time.at(REXML::XPath.first(doc, '//media').attributes["uploaddate"].to_i)
          true
        else
          false
        end
      #rescue
      #  false        
      end
      
      def self.media_api_request(api_call)
        params = {"format" => "xml",
                  "oauth_consumer_key" => Muri::Options.photobucket_api_key,
                  "oauth_nonce" => CGI::escape(Digest::MD5.hexdigest(Time.now.to_s)),
                  "oauth_signature_method" => CGI::escape('HMAC-SHA1'),
                  "oauth_timestamp" => "#{Time.now.to_i}",
                  "oauth_version" => "1.0"}
                  
        param_string = params.sort.inject(''){ |str, key| str << "#{key.first}=#{params[key.first]}&" }.chop

        request_url = "GET&" + (CGI::escape api_call) + "&" + CGI::escape(param_string)
        digest = OpenSSL::HMAC.digest('sha1', Muri::Options.photobucket_secret.to_s + "&", request_url)
        signature_hash = CGI::escape(Base64.encode64(digest).chomp)
        
        "#{api_call}?#{param_string}&oauth_signature=#{signature_hash}"
      end
      
      
      #def photobucket_nokogiri
        #doc = Nokogiri::XML(open(Muri::Fetcher::Photobucket.media_api_request(api_url)))
        #self.media_title          = doc.search("title").inner_text
        #self.media_description    = doc.search("description").inner_text
        #self.media_keywords       = doc.search("tag").collect{ |t| t["tag"] }
        #self.media_thumbnail      = doc.search("thumb").inner_text
        #self.media_posted         = Time.at(doc.search('media').first["uploaddate"].to_i)
      #end
    end
  end
end
#<?xml version="1.0" encoding="UTF-8"?>
#<response>
#	<status>OK</status>
#	<content>
#		<media description_id="" name="bokeh1.jpg" public="1" type="image" uploaddate="1253822012" username="findstuff22">
#			<browseurl>http://s0006.photobucket.com/albums/0006/findstuff22/Best%20Images/Photography/?action=view&amp;current=bokeh1.jpg</browseurl>
#			<url>http://i0006.photobucket.com/albums/0006/findstuff22/Best%20Images/Photography/bokeh1.jpg</url>
#			<thumb>http://i0006.photobucket.com/albums/0006/findstuff22/Best%20Images/Photography/th_bokeh1.jpg</thumb>
#
#			<description>Learn how to make Bokeh: http://blog.photobucket.com/blog/2009/12/bokeh-tutorial.html</description>
#			<title>Bokeh</title>
#			<isSponsored />
#			<tag bottom_right_x="1" bottom_right_y="1" tag="photography" top_left_x="0" top_left_y="0" />
#			<tag bottom_right_x="1" bottom_right_y="1" tag="bokeh" top_left_x="0" top_left_y="0" />
#			<tag bottom_right_x="1" bottom_right_y="1" tag="lights" top_left_x="0" top_left_y="0" />
#			<tag bottom_right_x="1" bottom_right_y="1" tag="christmas lights" top_left_x="0" top_left_y="0" />
#		</media>
#
#	</content>
#	<format>xml</format>
#	<method>GET</method>
#	<timestamp>1271288153</timestamp>
#</response>
#<!-- den3ws215 @ Wed, 14 Apr 2010 17:35:53 -0600 -->

