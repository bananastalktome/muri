require 'uri'
class Muri

  attr_accessor :media, :errors, :url

  # NoParser raised if no parser is found for URI
  class NoParser < StandardError; end
  
  # UnsupportedURI raised if parser is found, but URI path does not 
  #   match accepted formats
  class UnsupportedURI < ArgumentError; end
  
  PARSERS = { }
  
  include Filter::Youtube
  include Filter::Flickr
  include Filter::Vimeo
  include Filter::Imageshack
  include Filter::Photobucket
  include Filter::Facebook
  include Filter::Twitpic  

  def self.parse(url)
    self.new(url)
  end
    
  def initialize(url)
    self.media = { }
    _parse(url)
  end  
  
  def to_s
    self.media.to_s
  end
  
  # Determine if Muri object is valid (errors mean not valid)
  def valid?
    self.errors.nil?
  end
  
  # 'Borrowed' from uri/generic.rb
  @@to_s = Kernel.instance_method(:to_s)
  def inspect
    @@to_s.bind(self).call.sub!(/>\z/) {" URL:#{self.media_original_url}>"}
  end
  
  # Show a list of the available parsers
  def parsers
    PARSERS.keys
  end
  
  private
  
  def _parse(raw_url)
    begin
      self.url = URI.parse(raw_url)
      if self.url.scheme.nil?
        raw_url = "http://#{raw_url}"
        self.url = URI.parse(raw_url)
      end
      if parser = determine_feed_parser
        self.media_uri = self.url
        self.media_original_url = raw_url
        send(PARSERS[parser])
      else
        raise NoParser
      end
    rescue NoParser, UnsupportedURI, URI::BadURIError, URI::InvalidURIError => e
      self.errors = "#{e.class}"
    end
  end
  
  def determine_feed_parser
    PARSERS.keys.detect {|klass| klass.parsable?(self.url)}
  end


  def method_missing(method, *arguments, &block)
    if method.to_s =~ /media_(.+)/
      process_option_method(method, *arguments)
    else
      super
    end
  end
  
  def process_option_method(method, *arguments)
    if method.to_s =~ /media_(.+)=/
      self.media[$1.to_sym] = arguments.first
    elsif method.to_s =~ /media_(.+)/
      self.media[$1.to_sym]
    end
  end
  
  protected
  
  #used by flickr. Ported from PHP.
  def self.decode58(str)
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
  def self.encode58(str)
    alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
    base_count = alphabet.length
    encoded = ''
    while str >= base_count
      div = str / base_count
      mod = (str-(base_count * div))
      encoded = alphabet[mod,1] + encoded
      str = div
    end
    encoded = (alphabet[str,1] + encoded) if str
    encoded
  end
end
