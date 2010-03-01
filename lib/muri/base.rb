require 'uri'
class Muri
  class NoParser < StandardError; end
  class UnsupportedURI < ArgumentError; end
    
  PARSERS = {}
  
  include Filter::Youtube
  include Filter::Flickr
  include Filter::Vimeo
  include Filter::Imageshack
  include Filter::Photobucket

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
  
  def parsed?
    @info[:media_id].nil? ? false : true
  end
  
  # Taken from uri/generic.rb
  @@to_s = Kernel.instance_method(:to_s)
  def inspect
    @@to_s.bind(self).call.sub!(/>\z/) {" URL:#{self.original_url}>"}
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
    if parser = determine_feed_parser
      @info[:uri] = @url
      @info[:original_url] = raw_url
      send(PARSERS[parser])
    else
      raise NoParser.new("No Transformer found for URL")
    end
    
  #rescue => e
    #raise "failed #{e}"
  end
  
  def determine_feed_parser
    PARSERS.keys.detect {|klass| klass.parsable?(@url)}
  end
      
  def method_missing(func, args = nil)
    if @info[func.to_sym] != nil
      @info[func.to_sym]
    else
      nil #super(func,args)
    end
  end
  
  protected
  
  #used by flickr. Ported from PHP.
  def decode58(str)
    decoded = 0
    multi = 1
    alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    while str.length > 0
      digit = str[(str.length - 1),1]
      decoded += multi * alphabet.index(digit)
      multi = multi * alphabet.length
      str.chop!
    end
    
    decoded
  end
  
  #used by flickr. Ported from PHP.
  def encode58(str)
    alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    base_count = alphabet.length
    encoded = ''
    while str >= base_count
      div = str / base_count
      mod = (str-(base_count * div.to_i))
      encoded = alphabet[mod,1] + encoded
      str = div.to_i
    end
    encoded = (alphabet[str,1] + encoded) if str
    encoded
  end
end
