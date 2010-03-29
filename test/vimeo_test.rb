require 'lib/muri.rb'

shared_examples_for "Vimeo parse" do
  it "should be Vimeo service" do
    @a.media_service.should == 'Vimeo'
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
end
shared_examples_for "Vimeo parse album" do
  it_should_behave_like "Vimeo parse"
  
  it "should have media api type = VIMEO_ALBUM" do
    @a.media_api_type.should == Muri::VIMEO_ALBUM
  end   
end

{'http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1' =>
  { :type => :video,
    :media_id => '7312128',
    :media_url => 'http://vimeo.com/moogaloop.swf?clip_id=7312128&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1',
    :media_website => 'http://vimeo.com/7312128',
    :media_api_id => '7312128'
  },
  'http://vimeo.com/7312128' =>
  { :type => :video,
    :media_id => '7312128',
    :media_url => "http://vimeo.com/moogaloop.swf?clip_id=7312128&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1",
    :media_website => 'http://vimeo.com/7312128',
    :media_api_id => '7312128'
  },
  'http://vimeo.com/album/89702' =>
  { :type => :album,
    :media_id => '89702',
    :media_website => 'http://vimeo.com/album/89702',
    :media_api_id => '89702'
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
