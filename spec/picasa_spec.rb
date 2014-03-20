require File.expand_path(File.dirname(__FILE__) + '/../lib/muri.rb')

shared_examples_for "Picasa parse" do
  it "should be Picasa service" do
    @a.picasa?.should == true
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

shared_examples_for "Picasa parse photo" do
  it_should_behave_like "Picasa parse"
  it "should have media api type = PICASA_PHOTO" do
    @a.media_api_type.should == Muri::PICASA_PHOTO
  end
  
  it "should be picasa photo" do
    @a.picasa_photo?.should == true
  end 
  
  it "should not be facebook photo" do
    @a.facebook_photo?.should == false
  end      
end

{'http://picasaweb.google.com/bananastalktome/TestForAPI#5450524726782297346' => 
  { :media_id => '5450524726782297346',
    :media_website => 'http://picasaweb.google.com/bananastalktome/TestForAPI#5450524726782297346',
    :media_api_id => 'bananastalktome/album/TestForAPI/photoid/5450524726782297346'
  }
}.each do |url, values|
  
  describe "Picasa parse #{values[:type]} #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    it_should_behave_like "Picasa parse photo"

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
