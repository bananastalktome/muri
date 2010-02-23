require 'uri'
class MURI
  class NoTransformer < StandardError; end
    
  PARSERS = { }

  include Filter::Youtube
  include Filter::Flickr
  include Filter::Vimeo
  
  def self.parse(url)
    self.new(url)
  end
  
  def initialize(url)
    @info = { }
    _parse(url)
  end  

  def to_yaml
    @info.to_yaml
  end
  
  def to_s
    @info.to_s
  end
    
  # Taken from uri/generic.rb
  @@to_s = Kernel.instance_method(:to_s)
  def inspect
    @@to_s.bind(self).call.sub!(/>\z/) {" #{self}>"}
  end
  
  def parsers
    PARSERS.keys  
  end
  
  private
  
  def _parse(raw_url)
    @url = URI.parse(raw_url)
    if @url.scheme.nil?
      raw_url = "http://#{raw_url}"
      @url = URI.parse(raw_url)
    end
    if parse_function = PARSERS[@url.host]
      @info[:uri] = @url
      @info[:original_url] = raw_url
      @info.merge! self.class.send(parse_function, @url)
    else
      raise NoTransformer.new("No Transformer found for URL")
    end
    
  #rescue => e
    #raise "failed #{e}"
  end
      
  def field_value(field_name)
    if @info[field_name.to_sym] != nil
      @info[field_name.to_sym]
    else
      nil
    end
  end
  
  def method_missing(func, args = nil)
    field_value(func)
  end
end
