require 'uri'
class Muri

  attr_reader :url, :errors

  # NoParser raised if no parser is found for URI
  class NoParser < StandardError; end

  # UnsupportedURI raised if parser is found, but URI path does not
  #   match accepted formats
  class UnsupportedURI < ArgumentError; end

  PARSERS = { }

  ['Youtube', 'Flickr', 'Vimeo', 'Imageshack', 'Photobucket', 'Facebook', 'Twitpic'].each do |filter|
    eval("include Filter::#{filter}")
    self.constants.reject { |c| c !~ /^#{filter.upcase}/ }.each do |exp|
      meth = (exp.to_s.downcase + "?").to_sym
      define_method(meth) { self.media_api_type == eval(exp) }
    end
  end

  def self.parse(url)
    self.new(url)
  end

  def initialize(url)
    @info = { }
    _parse(url)
  end

  def to_s
    @info.to_s
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
  attr_writer :url, :errors

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
