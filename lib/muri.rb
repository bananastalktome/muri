# Register built-in filters
Dir["#{File.dirname(__FILE__) + '/muri/filters'}/**/*"].each do |filter|
  require "#{filter}"
end

# Just base now..more later(?)
%w(filter base).each do |f|
  require File.dirname(__FILE__) + "/muri/#{f}"
end
