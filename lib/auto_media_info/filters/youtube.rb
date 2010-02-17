module Youtube
  def self.included(base)
    base.class_eval do
      PARSERS["www.youtube.com"] = "youtube_parse"
      PARSERS["youtube.com"] = "youtube_parse" 
      
      def self.youtube_parse(url)
        url_components = URI.parse(url)
        url_components
      end                            
    end
  end
#  def self.youtube_parse(url)
#    url
#  end
#http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&
#http://www.youtube.com/watch?v=l983Uob0Seo&feature=rec-LGOUT-exp_fresh+div-1r-1-HM
end