class Muri
  module Fetcher
    
    MuriOptions.keys.each do |fetcher|
      if fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i }
        eval "include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}"
      end
    end
    
    Muri::AVAILABLE_FETCHERS.each do |fetcher|
      fetcher = fetcher.downcase.to_sym
      define_method("enable_#{fetcher}_fetcher") { set_muri_options(fetcher, :enabled, true) }
      define_method("#{fetcher}_api_key=") { |key| set_muri_options(fetcher, :api_key, key) }
      define_method("#{fetcher}_secret=") { |key| set_muri_options(fetcher, :secret, key) }
      define_method("disable_#{fetcher}_fetcher"){ MuriOptions.delete(fetcher) }
    end
    
    def set_muri_options(fetcher, key, value, include_module = true)
      Muri::Options.send("#{fetcher.downcase}_#{key}=", value)
      MuriOptions[fetcher.downcase.to_sym] ||= { }
      MuriOptions[fetcher.downcase.to_sym][key] = value
      if include_module && (fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i })
        eval("include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}")
      end

    end
    
    protected

    def fetch_xml(url)
      xml = Net::HTTP.get_response(URI.parse(url)).body
      doc = REXML::Document.new(xml)
      raise if doc.is_a?(String) #meaning error...
      doc
    end
  end

end

# class Muri
#   module Fetcher
#     
#     def self.included(base)
#       base.extend ClassMethods
#     end
#   
#     module ClassMethods
#       MuriOptions.keys.each do |fetcher|
#         if fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i }
#           eval "include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}"
#         end
#       end
#       
#       Muri::AVAILABLE_FETCHERS.each do |fetcher|
#         fetcher = fetcher.downcase.to_sym
#         define_method("enable_#{fetcher}_fetcher") { set_muri_options(fetcher, :enabled, true) }
#         define_method("#{fetcher}_api_key=") { |key| set_muri_options(fetcher, :api_key, key) }
#         define_method("#{fetcher}_secret=") { |key| set_muri_options(fetcher, :secret, key) }
#         define_method("disable_#{fetcher}_fetcher"){ MuriOptions.delete(fetcher) }
#       end
#       
#       def set_muri_options(fetcher, key, value, include_module = true)
#         MuriOptions[fetcher.downcase.to_sym] ||= { }
#         MuriOptions[fetcher.downcase.to_sym][key] = value
#         if include_module && (fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i })
#           eval("include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}")
#         end
#       end
# 
#       def fetch_xml(url)
#         xml = Net::HTTP.get_response(URI.parse(url)).body
#         doc = REXML::Document.new(xml)
#         raise if doc.is_a?(String) #meaning error...
#         doc
#       end
#     end
#   
#   end
# end
