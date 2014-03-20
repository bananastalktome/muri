require File.expand_path(File.dirname(__FILE__) + '/../lib/muri.rb')

shared_examples_for "Vimeo parse" do
  it "should be Vimeo service" do
    #@a.media_service.should == 'Vimeo'
    @a.vimeo?.should == true
  end
  
  it "should be not be other services" do
    @a.photobucket?.should == false
    @a.youtube?.should == false
    @a.facebook?.should == false
    @a.flickr?.should == false
  end
    
  it "should be valid" do
    @a.valid?.should == true
  end

end

shared_examples_for "Vimeo parse video" do
  it_should_behave_like "Vimeo parse"
  
  it "should have media api type = VIMEO_VIDEO" do
    @a.media_api_type.should == Muri::VIMEO_VIDEO
  end   
  
  it "should be vimeo video" do
    @a.vimeo_video?.should == true
  end  
  
  it "should not be youtube video" do
    @a.youtube_video?.should == false
  end   
end
shared_examples_for "Vimeo parse album" do
  it_should_behave_like "Vimeo parse"
  
  it "should have media api type = VIMEO_ALBUM" do
    @a.media_api_type.should == Muri::VIMEO_ALBUM
  end   
  
  it "should be vimeo album" do
    @a.vimeo_album?.should == true
  end  
  
  it "should not be photobucket album" do
    @a.photobucket_album?.should == false
  end     
end

{'http://vimeo.com/moogaloop.swf?clip_id=89009115&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1' =>
  { :type => :video,
    :media_id => '89009115',
    :media_url => 'http://player.vimeo.com/video/89009115',
    :media_website => 'http://vimeo.com/89009115',
    :media_api_id => '89009115'
  },
  'http://vimeo.com/89009115' =>
  { :type => :video,
    :media_id => '89009115',
    :media_url => 'http://player.vimeo.com/video/89009115',
    :media_website => 'http://vimeo.com/89009115',
    :media_api_id => '89009115'
  },
  'http://vimeo.com/album/89702' =>
  { :type => :album,
    :media_id => '89702',
    :media_website => 'http://vimeo.com/album/89702',
    :media_api_id => '89702'
  },
  'http://player.vimeo.com/video/89009115' =>
  { :type => :video,
    :media_id => '89009115',
    :media_website => 'http://vimeo.com/89009115',
    :media_api_id => '89009115'
  }
}.each do |url, values|
  describe "Vimeo parse #{values[:type]} #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    if values[:type] == :video    
      it_should_behave_like "Vimeo parse video"
    elsif values[:type] == :album    
      it_should_behave_like "Vimeo parse album"
    end
    
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_url]
      it "should have a media url" do
        @a.media_url.should == values[:media_url]
      end
    end
    
    if values[:media_website]
      it "should have a website" do
        @a.media_website.should == values[:media_website]
      end
    end
    
    if values[:media_api_id]     
      it "should have media api id" do
        @a.media_api_id.should == values[:media_api_id]
      end
    end
  end
end
