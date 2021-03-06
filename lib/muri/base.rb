class Muri

  attr_reader :uri, :errors

  # NoParser raised if no parser is found for URI
  class NoParser < StandardError; end

  # UnsupportedURI raised if parser is found, but URI path does not
  #   match accepted formats
  class UnsupportedURI < ArgumentError; end

  AVAILABLE_PARSERS = %w[youtube flickr vimeo imageshack photobucket facebook twitpic picasa].freeze

  PARSERS = { }
  
  # Defines #{service}? and #{service_type}? methods, and sets service name constnat
  AVAILABLE_PARSERS.each do |parser|
    eval "include Filter::#{parser.capitalize}"    
    service = "#{parser}?"
    define_method(service) { self.media_service == parser }    
    self.constants.reject { |c| c !~ /^#{parser.upcase}/ }.each do |exp|
      define_method("#{exp.downcase}?") do
        self.media_api_type == eval("#{exp}") && self.instance_eval(service)
      end
    end
    const_set "#{parser.upcase}_SERVICE_NAME", "#{parser}"
  end

  def self.parse(url)
    self.new(url)
  end

  # Show a list of the available parsers
  def self.parsers
    PARSERS.keys
  end
  
  def initialize(url)
    @info = { }
    parse(url)
  end
  
  # Determine if Muri object is valid (errors mean not valid)
  def valid?
    self.errors.nil?
  end
  
  def to_s
    @info.to_s
  end

  # 'Borrowed' from uri/generic.rb
  def inspect
    Kernel.instance_method(:to_s).bind(self).call.sub!(/>\z/) {" URL:#{self.uri.to_s}>"}
  end

  private
  attr_writer :uri, :errors

  def self.determine_feed_parser(uri)
    PARSERS.keys.detect {|klass| klass.parsable?(uri)}
  end
  
  def parse(raw_url)
    begin
      raw_url = URI.encode(URI.decode(raw_url), " ") unless raw_url.nil?
      self.uri = URI.parse(raw_url)
      if self.uri.scheme.nil?
        raw_url = "http://#{raw_url}"
        self.uri = URI.parse(raw_url)
      end
      if parser = Muri.determine_feed_parser(self.uri)
        send(PARSERS[parser])
      else
        raise NoParser
      end
    rescue NoParser, UnsupportedURI, URI::BadURIError, URI::InvalidURIError => e
      self.errors = "#{e.class}"
    end
  end

  def method_missing(method, *arguments, &block)
    if method.to_s =~ /^media_(.+)/
      process_option_method(method, *arguments)
    else
      super
    end
  end

  def process_option_method(method, *arguments)
    if method.to_s =~ /^media_(.+)=/
      @info[$1.to_sym] = arguments.first
    elsif method.to_s =~ /^media_(.+)/
      @info[$1.to_sym]
    end
  end
end
