require 'cgi'
require 'pp'
module Youtube

  def self.included(base)
    base.class_eval do
      self::PARSERS["www.youtube.com"] = "youtube_parse"
      self::PARSERS["youtube.com"] = "youtube_parse"
    end
  end
  def youtube_parse
    
    @info[:service] = 'Youtube'
    
    if (@url.path == "/watch") && !@url.query.nil?
      #params = url_components.query.to_params
      params = CGI::parse(@url.query)
      @info[:media_id] = params["v"].first
      
    elsif (@url.path =~ /\/v\/([a-zA-Z0-9\-\_]*)/i)
      @info[:media_id] = $1
      
    end
    pp @info
    self
  end
  
end
#  def self.youtube_parse(url)
#    url
#  end
#http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&
#http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM