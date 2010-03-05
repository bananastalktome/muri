require 'lib/muri.rb'

describe "Parse Errors" do
  @no_parser = ["http://media.photobucket.com/image/searchterm/pbapi/file.jpg",
        "http://pic.pbsrc.com/dev_help/WebHelpPublic/PhotobucketPublicHelp.htm"]
  
  @unsupported = ["http://gi0006.photobucket.com/groups/0006/",
                  "http://www.flickr.com/photos",
                  "http://img178.imageshack.us/img178/",
                  "http://img178.imageshack.us/img178/773/",
                  "http://vimeo.com/",
                  "http://vimeo.com/moogaloop.swf?server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1",
                 "http://vimeo.com/moogaloop.swf?server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1"]
  
  @no_parser.each do |a|
    it "#{a} should return NoParser" do
      #lambda { Muri.parse a }.should raise_exception(Muri::NoParser)
      m = Muri.parse a
      m.valid? == false
      m.errors == "Muri::NoParser"
    end
  end
  
  @unsupported.each do |b|
    it "#{b} should return UnsupportedURI" do
      #lambda { Muri.parse b }.should raise_exception(Muri::UnsupportedURI)
      m = Muri.parse b
      m.valid? == false
      m.errors == "Muri::UnsupportedURI"
    end
  end
  
end
