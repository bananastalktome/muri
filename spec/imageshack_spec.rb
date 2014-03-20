require File.expand_path(File.dirname(__FILE__) + '/../lib/muri.rb')

shared_examples_for "Imageshack parse" do
  it "should be Imageshack service" do
    #@a.media_service.should == 'Imageshack'
    @a.imageshack?.should == true
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

{'http://img178.imageshack.us/i/dsc01576lo7.jpg/' =>
  { :media_id => 'dsc01576lo7',
    :media_website => 'http://img178.imageshack.us/i/dsc01576lo7.jpg/',
    :media_content_type => 'jpg'
  },
'http://img178.imageshack.us/img178/773/dsc01576lo7.jpg' =>
  { :media_id => 'dsc01576lo7',
    :media_website => 'http://img178.imageshack.us/i/dsc01576lo7.jpg/',
    :media_content_type => 'jpg',
    :media_url => 'http://img178.imageshack.us/img178/773/dsc01576lo7.jpg'
  }
}.each do |url, values|
  
  describe "Imageshack parse #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    it_should_behave_like "Imageshack parse"
    
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_website]
      it "should have website" do
        @a.media_website.should == values[:media_website]
      end
    end
    
    if values[:media_content_type] 
      it "should have content_type" do
        @a.media_content_type.should == values[:media_content_type] 
      end  
    end
    
    if values[:media_url]
      it "should have media_url" do
        @a.media_url.should == values[:media_url]
      end
    end
  end
end