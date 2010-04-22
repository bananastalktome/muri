class Muri
  module Filter
    
    def self.included(base)
      base.class_eval do
        # Defines #{service}? and #{service_type}? methods, and sets service name constnat
        Muri::AVAILABLE_PARSERS.each do |parser|
          eval "include Filter::#{parser.capitalize}"
          service = "#{parser.downcase}?"
          define_method(service) { self.media_service == parser }
          self.constants.reject { |c| c !~ /^#{parser.upcase}/ }.each do |exp|
            define_method("#{exp.downcase}?") do
              self.media_api_type == eval(exp) && self.instance_eval(service)
            end
          end
          const_set "#{parser.upcase}_SERVICE_NAME", "#{parser}"
        end
      end
    end
  
  end
end
