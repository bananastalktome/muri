class Muri
  module Filter
    module Imageshack

      private

      def self.included(base)
        base.class_eval do
          self::PARSERS[Muri::Filter::Imageshack] = "imageshack_parse"
        end
      end

      def self.parsable?(uri)
        uri.host =~ /^img([0-9]*?)\.imageshack\.us$/i #/^(img([0-9]*?)\.imageshack\.us)|(yfrog\.com)/i
      end

      def imageshack_parse
       self.media_service = 'Imageshack'

        self.url.host =~ /^img([0-9]*?)\.imageshack\.us/i
        server_id = $1
        url_common = "http://img#{server_id}.imageshack.us"

        if self.url.path =~ /^\/i\/([a-z0-9]+?)\.([a-z0-9]+)(\/)?/i
          self.media_id = $1
          self.media_content_type = $2
        elsif self.url.path =~ /^\/img([0-9]*?)\/([0-9]+?)\/([a-z0-9]+?)\.([a-z0-9]+)/i
          content_server_id = $2
          self.media_id = $3
          self.media_content_type = $4
          self.media_url = "#{url_common}/img#{server_id}/#{content_server_id}/#{self.media_id}.#{self.media_content_type}"
        else
          raise UnsupportedURI
        end

        # imageshack does not currently have API for retrieving individual video information
        self.media_website = "#{url_common}/i/#{self.media_id}.#{self.media_content_type}/"
      end

    end
  end
end
# http://img178.imageshack.us/i/dsc01576lo7.jpg/ (preview)
# http://img178.imageshack.us/img178/773/dsc01576lo7.jpg (direct)
# http://yfrog.com/4ydsc01576lo7j

# http://img30.imageshack.us/img30/4184/rush02.mp4
# http://img30.imageshack.us/i/rush02.mp4/
# http://yfrog.us/0urush02z => http://code.google.com/p/imageshackapi/wiki/YFROGurls
