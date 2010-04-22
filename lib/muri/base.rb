class Muri

  attr_reader :uri, :errors

  # NoParser raised if no parser is found for URI
  class NoParser < StandardError; end

  # UnsupportedURI raised if parser is found, but URI path does not
  #   match accepted formats
  class UnsupportedURI < ArgumentError; end
  
  include Filter
  extend Fetcher

  def self.parse(url)
    self.new(url)
  end

  # Fetch and return in obj clone
  def self.fetch(obj)
    copy = obj.clone
    copy.fetch!
    copy
  end
  
  def self.parse_and_fetch(url)
    obj = self.parse(url)
    obj.fetch!
    obj
  end

  # Show a list of the available parsers
  def self.parsers
    PARSERS.keys
  end
  
  # Show a list of the available fetchers
  def self.fetchers
    FETCHERS.keys
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
  
  def fetch!
    self.send(FETCHERS[self.media_service]) if self.valid? && FETCHERS[self.media_service]
  end
  
  private
  attr_writer :uri, :errors

  def self.param_parse(query)
    return { } if query.nil?
    params_flat = { }
    params = CGI::parse(query)
    params.each {|k,v| params_flat[k] = v.first}
    params_flat
  end

  def self.determine_feed_parser(uri)
    PARSERS.keys.detect {|klass| klass.parsable?(uri)}
  end
  
  def parse(raw_url)
    begin
      raw_url = URI.encode(URI.decode(raw_url)) unless raw_url.nil?
      self.uri = URI.parse(raw_url)
      if self.uri.scheme.nil?
        raw_url   = "http://#{raw_url}"
        self.uri  = URI.parse(raw_url)
      end
      if parser = Muri.determine_feed_parser(self.uri)
        send(PARSERS[parser])
      else
        raise NoParser
      end
    rescue NoParser, UnsupportedURI, URI::BadURIError, URI::InvalidURIError, OpenURI::HTTPError => e
      self.errors = "#{e.class}"
    end
  end
  
  def initialize_copy(source)  
    super
    @info = @info.dup  
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
