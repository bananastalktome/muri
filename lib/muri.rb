require 'uri'
require 'cgi'
require 'open-uri'
require 'rexml/document'
require 'net/http'
#require 'nokogiri'

class Muri
  AVAILABLE_PARSERS = %w[Youtube Flickr Vimeo Imageshack Photobucket Facebook Twitpic Picasa].freeze
  AVAILABLE_FETCHERS = %w[Youtube Flickr Vimeo Photobucket Picasa].freeze
  #class Options
  #  #attr_accessor :options
  #  #Muri::Options.vimeo_enabled
  #  #Muri::Options.vimeo_api_key
  #  class << self
  #    Muri::AVAILABLE_FETCHERS.each do |fetcher|
  #      define_method("#{fetcher.downcase}") {}
  #      define_method("#{fetcher.downcase}_enabled=") {}
  #    
  #    end
  #  end
  #end
end

if ENV.include?('RAILS_ENV')
  if (File.file? "#{RAILS_ROOT}/config/muri.yaml")
    MuriOptions = YAML.load_file("#{RAILS_ROOT}/config/muri.yaml")
    MuriOptions.delete_if do |key, val_hash|
      val_hash[:api_key].nil? && !(val_hash[:enabled] == true)
    end
  end
end

MuriOptions = {} if not Object.const_defined? :MuriOptions
#MuriOptions[:flickr] ||= {:api_key => 'SOME API KEY'}

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
