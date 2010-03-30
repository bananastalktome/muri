require 'lib/muri.rb'

shared_examples_for "Facebook parse" do
  it "should be Facebook service" do
    #@a.media_service.should == 'Facebook'
    @a.is_facebook?.should == true
  end
  
  it "should be not be other services" do
    #@a.media_service.should == 'Facebook'
    @a.is_vimeo?.should == false
    @a.is_flickr?.should == false
    @a.is_youtube?.should == false
  end
  
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Facebook parse photo" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_PHOTO" do
    @a.media_api_type.should == Muri::FACEBOOK_PHOTO
  end
  
  it "should be facebook photo" do
    @a.is_facebook_photo?.should == true
  end
  
  it "should not be flickr photo" do
    @a.is_flickr_photo?.should == false
  end  
end

{'http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063' =>
  { :media_id => '34929102',
    :media_website => 'http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063',
    :media_api_id => 65288068484364750
  }
}.each do |url, values|
  describe "Facebook parse #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    it_should_behave_like "Facebook parse photo"
  
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
  end
end