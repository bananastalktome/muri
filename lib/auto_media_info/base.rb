require 'uri'
module AMI
  class NoTransformer < StandardError; end
  
  PARSERS = { }
  
  require "#{File.dirname(__FILE__) + '/filters/youtube.rb'}"
  
  def self.parse(url)
    url_components = URI.parse(url)
    if url_components.scheme.empty?
      url = "http://#{url}"
      url_components = URI.parse(url)
    end
    if parse_function = PARSERS[url_components.host]
      self.send(parse_function, url)
    else
      raise NoTransformer.new("No Transformer found for URL")
    end
  end

end