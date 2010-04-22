require 'uri'
require 'cgi'
require 'open-uri'
require 'rexml/document'
require 'net/http'
require 'openssl'
require 'base64'

class Muri
  AVAILABLE_PARSERS = %w[Youtube Flickr Vimeo Imageshack Photobucket Facebook Twitpic Picasa].freeze
  AVAILABLE_FETCHERS = %w[Youtube Flickr Vimeo Photobucket Picasa].freeze
  PARSERS = { }
  FETCHERS = { }
  class Options
    class << self
      attr_reader :options
      
      SERVICE_KEYS = %w[enabled api_key secret]

      def options=(val) @options=val; end
      private 'options='
      
      def set_options(hash)
        hash.each do |key, val_hash|
          if Muri::AVAILABLE_FETCHERS.include? key.to_s.downcase
            val_hash.each { |k,v| Muri::Options.send("#{key}_#{k}=", v.to_s) unless (v.nil? || (v.strip == "") || !SERVICE_KEYS.include?(k.to_s.downcase)) }
          end
        end
      end
      
      def services
        @options.keys
      end
      
      def remove_service(service)
        @options.delete(service.to_sym) if @options.include?(service.to_sym)
      end
      
      Muri::AVAILABLE_FETCHERS.each do |fetcher|
        service = fetcher.downcase.to_sym
        SERVICE_KEYS.each do |method|
          define_method("#{service}_#{method}") do
            (@options.include?(service) && @options[service].include?(method.to_sym)) ? @options[service][method.to_sym] : nil
          end
          define_method("#{service}_#{method}=") do |val|
            @options ||= {}
            @options[service] ||= { }
            @options[service][method.to_sym] = val
          end
        end
      end
    end
  end
  
end

# Empty options
Muri::Options.send('options=', {})

# Register built-in filters
Dir["#{File.dirname(__FILE__) + '/muri/filters'}/**/*"].each do |filter|
  require "#{filter}"
end

# Register built-in fetchers

Dir["#{File.dirname(__FILE__) + '/muri/fetchers'}/**/*"].each do |fetcher|
  require "#{fetcher}"
end

# Register other stuff
%w(filter fetcher base).each do |f|
  require File.dirname(__FILE__) + "/muri/#{f}"
end


if ENV.include?('RAILS_ENV')
  require 'yaml'
  if (File.file? "#{RAILS_ROOT}/config/muri.yaml")
    Muri::Options.set_options YAML.load_file("#{RAILS_ROOT}/config/muri.yaml")
  end
end
