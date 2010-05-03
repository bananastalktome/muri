require 'lib/muri.rb'

shared_examples_for "Facebook parse" do
  it "should be Facebook service" do
    #@a.media_service.should == 'Facebook'
    @a.facebook?.should == true
  end
  
  it "should be not be other services" do
    #@a.media_service.should == 'Facebook'
    @a.vimeo?.should == false
    @a.flickr?.should == false
    @a.youtube?.should == false
  end
  
  it "should be valid" do
    @a.valid?.should == true
  end
end
shared_examples_for "Facebook parse album" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_VIDEO" do
    @a.media_api_type.should == Muri::FACEBOOK_ALBUM
  end
  
  it "should be facebook video" do
    @a.facebook_album?.should == true
  end
  
  it "should not be facebook photo" do
    @a.facebook_photo?.should == false
  end  
  
  it "should not be flickr media" do
    @a.flickr_media?.should == false
  end  
end

shared_examples_for "Facebook parse video" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_VIDEO" do
    @a.media_api_type.should == Muri::FACEBOOK_VIDEO
  end
  
  it "should be facebook video" do
    @a.facebook_video?.should == true
  end
  
  it "should not be facebook photo" do
    @a.facebook_photo?.should == false
  end  
  
  it "should not be flickr media" do
    @a.flickr_media?.should == false
  end  
end

shared_examples_for "Facebook parse photo" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_PHOTO" do
    @a.media_api_type.should == Muri::FACEBOOK_PHOTO
  end
  
  it "should be facebook photo" do
    @a.facebook_photo?.should == true
  end
  
  it "should not be flickr media" do
    @a.flickr_media?.should == false
  end  
end

{'http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063' =>
  { :type => :photo,
    :media_id => '34929102',
    :media_website => 'http://www.facebook.com/photo.php?pid=34929102&id=15201063',
    :media_api_id => '65288068484364750',
    :media_api_ids => {:pid => "34929102", :uid => "15201063", :fql_id => '65288068484364750'}
  },
'http://www.facebook.com/photo.php?pid=3343211&l=a1abf8cd37&id=322232#!/photo.php?pid=34929102&l=a1abf8cd37&id=15201063' =>
  { :type => :photo,
    :media_id => '34929102',
    :media_website => 'http://www.facebook.com/photo.php?pid=34929102&id=15201063',
    :media_api_id => '65288068484364750',
    :media_api_ids => {:pid => "34929102", :uid => "15201063", :fql_id => '65288068484364750'}
  },
'http://www.facebook.com/photo.php?pid=34929101&id=15201063#!/video/video.php?v=545993063513&subj=15201063' =>
  { :type => :video,
    :media_id => '545993063513',
    :media_website => "http://www.facebook.com/video/video.php?v=545993063513",
    :media_api_id => '545993063513'
  },
'http://www.facebook.com/home.php?#!/album.php?id=15201063&aid=2149275' =>
  { :type => :album,
    :media_id => '2149275',
    :media_website => 'http://www.facebook.com/album.php?aid=2149275&id=15201063',
    :media_api_id => '65288068451584923'    
  }
}.each do |url, values|
  describe "Facebook parse #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    if values[:type] == :photo
      it_should_behave_like "Facebook parse photo"
    elsif values[:type] == :video
      it_should_behave_like "Facebook parse video"
    elsif values[:type] == :album
      it_should_behave_like "Facebook parse album"
    end
  
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_api_ids]
      it "should have media api id hash" do
        @a.media_api_ids.should == values[:media_api_ids]
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