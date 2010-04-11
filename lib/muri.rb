require 'uri'
require 'cgi'
require 'open-uri'
require 'nokogiri'


if ENV.include?('RAILS_ENV')
  if (File.file? "#{RAILS_ROOT}/config/muri.yaml")
    MuriOptions = YAML.load_file("#{RAILS_ROOT}/config/muri.yaml")
    MuriOptions.delete_if{ |key, val_hash| val_hash[:api_key].nil? || (val_hash[:enabled] == false) }
  end
end

MuriOptions = {} if not Object.const_defined? :MuriOptions
#MuriOptions[:flickr] ||= {:api_key => 'SOME API KEY'}


# Register built-in filters
Dir["#{File.dirname(__FILE__) + '/muri/filters'}/**/*"].each do |filter|
  require "#{filter}"
end
Dir["#{File.dirname(__FILE__) + '/muri/fetchers'}/**/*"].each do |fetcher|
  require "#{fetcher}"
end

# Just base now..more later(?)
%w(filter base).each do |f|
  require File.dirname(__FILE__) + "/muri/#{f}"
end
