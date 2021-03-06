require File.expand_path(File.dirname(__FILE__) + '/../lib/muri.rb')

shared_examples_for "Flickr parse" do
  it "should be Flickr service" do
    # @a.media_service.should == 'Flickr'
    @a.flickr?.should == true
  end
  
  it "should be not be other services" do
    @a.vimeo?.should == false
    @a.youtube?.should == false
    @a.facebook?.should == false
    @a.photobucket?.should == false
  end
    
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Flickr parse photo" do
  it_should_behave_like "Flickr parse"
  it "should have media api type = FLICKR_PHOTO" do
    @a.media_api_type.should == Muri::FLICKR_MEDIA
  end
  
  it "should be flickr media" do
    @a.flickr_media?.should == true
  end 
  
  it "should not be facebook photo" do
    @a.facebook_photo?.should == false
  end      
end

shared_examples_for "Flickr parse set" do
  it_should_behave_like "Flickr parse"
  it "should have media api type = FLICKR_SET" do
    @a.media_api_type.should == Muri::FLICKR_SET
  end

  it "should be flickr set" do
    @a.flickr_set?.should == true
  end    
end

{'http://www.flickr.com/photos/bananastalktome/2088436532/' =>
  { :type => :photo,
    :media_id => '2088436532',
    :media_website => 'http://flic.kr/p/4bxMqq',
    :media_api_id => '2088436532'
  },
  'http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg' =>
  { :type => :photo,
    :media_id => '2088436532',
    :media_website => 'http://flic.kr/p/4bxMqq',
    :media_api_id => '2088436532',
    :media_thumbnail => 'http://farm3.staticflickr.com/2178/2088436532_ee07b4474e_t.jpg'
  },
  'http://farm3.staticflickr.com/2178/2088436532_ee07b4474e_b.jpg' =>
  { :type => :photo,
    :media_id => '2088436532',
    :media_website => 'http://flic.kr/p/4bxMqq',
    :media_api_id => '2088436532',
    :media_thumbnail => 'http://farm3.staticflickr.com/2178/2088436532_ee07b4474e_t.jpg'
  },
  'http://www.flickr.com/photos/bananastalktome/sets/72157623467777820/' =>
  { :type => :set,
    :media_id => '72157623467777820',
    :media_website => 'http://www.flickr.com/photos/bananastalktome/sets/72157623467777820',
    :media_api_id => '72157623467777820'
  },
  'http://www.flickr.com/photos/eyetwist/12814906754/in/set-72157594565593508' =>
  { :type => :photo,
    :media_id => '12814906754',
    :media_website => 'http://flic.kr/p/kwpKjb',
    :media_api_id => '12814906754'
  },
  'http://www.flickr.com/photos/12037949754@N01/155761353/' =>
  { :type => :photo,
    :media_id => '155761353',
    :media_website => 'http://flic.kr/p/eLjqz',
    :media_api_id => '155761353'
  }
}.each do |url, values|
  
  describe "Flickr parse #{values[:type]} #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    
    if values[:type] == :photo
      it_should_behave_like "Flickr parse photo"
    elsif values[:type] == :set
      it_should_behave_like "Flickr parse set"
    end
    
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
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
    
    if values[:media_thumbnail]
      it "should have media thumbnail" do
        @a.media_thumbnail.should == values[:media_thumbnail]
      end
    end
  end
end
