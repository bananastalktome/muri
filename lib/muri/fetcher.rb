class Muri
  module Fetcher
    
    Muri::Options.services.each do |fetcher|
      if fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i }
        eval "include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}"
      end
    end
    
    # Wrapper for Muri::Options
    Muri::AVAILABLE_FETCHERS.each do |fetcher|
      fetcher = fetcher.downcase
      define_method("enable_#{fetcher}_fetcher") { set_muri_options(fetcher, :enabled, true) }
      define_method("#{fetcher}_api_key=") { |key| set_muri_options(fetcher, :api_key, key) }
      define_method("#{fetcher}_secret=") { |key| set_muri_options(fetcher, :secret, key) }
      define_method("disable_#{fetcher}_fetcher") do
        Muri::Options.remove_service(fetcher)
        Muri::FETCHERS.delete(fetcher)# if Muri::FETCHERS.include?(fetcher)
      end
    end
    
    protected

    def fetch_xml(url, limit=3)
      raise ArgumentError, 'HTTP redirect too deep' if limit == 0
      
      xml = Net::HTTP.get_response(URI.parse(url))
      case xml
        when Net::HTTPSuccess then
          doc = REXML::Document.new(xml.body)
          raise if doc.is_a?(String) #meaning error...
          doc        
        when Net::HTTPRedirection then
          fetch_xml(xml['location'], limit - 1)
        else
          xml.error!
      end
    end
    
    private
    
    # Muri::Options wrapper, allowing inclusion of fetcher modules
    def set_muri_options(fetcher, key, value, include_module = true)
      Muri::Options.send("#{fetcher.downcase}_#{key}=", value)
      if (fetch = Muri::AVAILABLE_FETCHERS.index{|f| f =~ /^#{fetcher}$/i })
        eval("include Fetcher::#{Muri::AVAILABLE_FETCHERS[fetch]}")
      end
    end 
        
  end
end
