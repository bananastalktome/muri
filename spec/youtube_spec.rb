require 'lib/muri.rb'
shared_examples_for "Youtube parse" do
  it "should be Youtube service" do
    #@a.media_service.should == 'Youtube'
    @a.youtube?.should == true
  end
  
  it "should be not be other services" do
    @a.photobucket?.should == false
    @a.vimeo?.should == false
    @a.facebook?.should == false
    @a.flickr?.should == false
  end
    
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Youtube parse single" do
  it_should_behave_like "Youtube parse"
  
  it "should have media api type = YOUTUBE_VIDEO" do
    @a.media_api_type.should == Muri::YOUTUBE_VIDEO
  end
  
  it "should be youtube video" do
    @a.youtube_video?.should == true
  end
  
  it "should not be vimeo video" do
    @a.vimeo_video?.should == false
  end
end

shared_examples_for "Youtube parse playlist" do
  it_should_behave_like "Youtube parse"
  
  it "should have media api type = YOUTUBE_PLAYLIST" do
    @a.media_api_type.should == Muri::YOUTUBE_PLAYLIST
  end
  
  it "should be youtube playlist" do
    @a.youtube_playlist?.should == true
  end
end

{'http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&' =>
  { :type => :video,
    :media_id => '4CYDFoEz8rg',
    :media_api_id => '4CYDFoEz8rg',
    :media_website => 'http://www.youtube.com/watch?v=4CYDFoEz8rg',
    :media_url => 'http://www.youtube.com/v/4CYDFoEz8rg',
    :media_thumbnail => 'http://i.ytimg.com/vi/4CYDFoEz8rg/default.jpg'    
  },
  'http://www.youtube.com/watch?v=4CYDFoEz8rg' =>
  { :type => :video,
    :media_id => '4CYDFoEz8rg',
    :media_api_id => '4CYDFoEz8rg',
    :media_website => 'http://www.youtube.com/watch?v=4CYDFoEz8rg',
    :media_url => 'http://www.youtube.com/v/4CYDFoEz8rg',
    :media_thumbnail => 'http://i.ytimg.com/vi/4CYDFoEz8rg/default.jpg'
  },
  'http://www.youtube.com/p/57633EC69B4A10A2&hl=en_US&fs=1' =>
  { :type => :playlist,
    :media_id => '57633EC69B4A10A2',
    :media_api_id => '57633EC69B4A10A2',
    :media_website => 'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2',
    :media_url => 'http://www.youtube.com/p/57633EC69B4A10A2'
  },
  'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2' =>
  { :type => :playlist,
    :media_id => '57633EC69B4A10A2',
    :media_api_id => '57633EC69B4A10A2',
    :media_website => 'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2',
    :media_url => 'http://www.youtube.com/p/57633EC69B4A10A2'
  },
  "http://www.youtube.com/watch?v=IPFnWoYy_8w&feature=topvideos" =>
  { :type => :video,
    :media_id => 'IPFnWoYy_8w',
    :media_api_id => 'IPFnWoYy_8w'
  },
  "http://youtu.be/ZL1Jta1j42c" =>
  { :type => :video,
    :media_id => "ZL1Jta1j42c",
    :media_api_id => "ZL1Jta1j42c"
  },
  "http://youtu.be/ZL1Jta1j42c?hd=1" =>
  { :type => :video,
    :media_id => "ZL1Jta1j42c",
    :media_api_id => "ZL1Jta1j42c"
  },
  "http://youtu.be/QH2-TGUlwu4" =>
  { :type => :video,
    :media_id => "QH2-TGUlwu4",
    :media_api_id => "QH2-TGUlwu4"
  }
}.each do |url, values|
  describe "Youtube parse #{values[:type]} #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    if values[:type] == :playlist    
      it_should_behave_like "Youtube parse playlist"
    elsif values[:type] == :video    
      it_should_behave_like "Youtube parse single"
    end
  
    if values[:media_id]  
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_api_id]
      it "should have media api id" do
        @a.media_api_id.should == values[:media_api_id]
      end
    end
    
    if values[:media_website]
      it "should have media website" do
        @a.media_website.should == values[:media_website]
      end
    end
    
    if values[:media_url]
      it "should have media url" do
        @a.media_url.should == values[:media_url]
      end
    end
    
    if values[:media_thumbnail]
      it "should have thumbnail" do
        @a.media_thumbnail.should == values[:media_thumbnail]
      end
    end
  end
end
