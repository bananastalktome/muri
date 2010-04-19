require 'uri'
require 'cgi'
require 'open-uri'
require 'rexml/document'
require 'net/http'

class Muri
  AVAILABLE_PARSERS = %w[Youtube Flickr Vimeo Imageshack Photobucket Facebook Twitpic Picasa].freeze
  AVAILABLE_FETCHERS = %w[Youtube Flickr Vimeo Photobucket Picasa].freeze
  class Options
    class << self
      @options = { }
      def options=(value) @options=value; end
      private :options=
      
      SERVICE_VALUES = %w[enabled api_key secret]
      
      def set_options(hash)
        hash.each do |key, val_hash|
          if Muri::AVAILABLE_FETCHERS.include? key.to_s.downcase
            val_hash.each { |k,v| eval("Muri::Options.#{key}_#{k}=", "#{v}") unless (!SERVICE_NAMES.include?(k.to_s.downcase) || v.nil? || (v.strip == "")) }
          end
        end
      end
      
      def services
        @options.class
      end
      
      Muri::AVAILABLE_FETCHERS.each do |fetcher|
        service = fetcher.downcase.to_sym
        SERVICE_VALUES.each do |method|
          define_method("#{service}_#{method}") do
            (@options.include?(service) && @options[service].include?(method.to_sym)) ? @options[service][method.to_sym] : nil
          end
          define_method("#{service}_#{method}=") do |val|
            @options ||= {}
            @options[service] ||= { }
            @options[service][method.to_sym] = val
            if (fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i })
              eval("include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}")
            end            
          end
        end
      end
    end
  end
end



#if ENV.include?('RAILS_ENV')
#  if (File.file? "#{RAILS_ROOT}/config/muri.yaml")
#    MuriOptions = YAML.load_file("#{RAILS_ROOT}/config/muri.yaml")
#    MuriOptions.delete_if do |key, val_hash|
#      val_hash[:api_key].nil? && !(val_hash[:enabled] == true)
#    end
#  end
#end

#MuriOptions = {} if not Object.const_defined? :MuriOptions
##MuriOptions[:flickr] ||= {:api_key => 'SOME API KEY'}

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
  if (File.file? "#{RAILS_ROOT}/config/muri.yaml")
    Muri::Options.set_options YAML.load_file("#{RAILS_ROOT}/config/muri.yaml")
  end
end
