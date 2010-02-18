# Register built-in filters
#
Dir["#{File.dirname(__FILE__) + '/auto_media_info/filters'}/**/*"].each do |filter|
  require "#{filter}"
end

%w(base filter builder).each do |f|
  require File.dirname(__FILE__) + "/auto_media_info/#{f}"
end
 
