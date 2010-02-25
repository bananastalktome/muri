require 'uri'
class Muri
  class NoParser < StandardError; end
    
  PARSERS = {}
  
  #include Filter::Youtube
  #include Filter::Flickr
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
  
  def parsed?
    @info[:media_id].nil? ? false : true
  end
  
  # Taken from uri/generic.rb
  @@to_s = Kernel.instance_method(:to_s)
  def inspect
    @@to_s.bind(self).call.sub!(/>\z/) {" URL:#{self.original_url}>"}
  end
  
  def parsers
    PARSERS  
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
end
