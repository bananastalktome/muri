require 'cgi'
module Flickr

  def self.included(base)
    base.class_eval do
      self::PARSERS["www.flickr.com"] = "flickr_parse"
      self::PARSERS["youtube.com"] = "youtube_parse"
    end
  end
  def flickr_parse
    
    @info[:service] = 'Flickr'
    
 
    self
  end
  
end
#  def self.youtube_parse(url)
#    url
#  end
#http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&
#http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM