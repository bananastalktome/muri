require 'uri'
module AMI
  class NoTransformer < StandardError; end

  module Parser
    class << self; attr_accessor :service, :url end
    @service = ''
    @url = ''
    PARSERS = { }

    include Filter::Youtube
    
    def self.parse(url)
      url_components = URI.parse(url)
      if url_components.scheme.nil?
        url = "http://#{url}"
        url_components = URI.parse(url)
      end
      if parse_function = PARSERS[url_components.host]
        self.url = url        
        self.send(parse_function, url)
      else
        raise NoTransformer.new("No Transformer found for URL")
      end
    end
  end

end