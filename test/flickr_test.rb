require 'lib/muri.rb'
shared_examples_for "Flickr parse" do
  it "should be Flickr service" do
    @a.media_service.should == 'Flickr'
  end
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Flickr parse photo" do
  it_should_behave_like "Flickr parse"
  it "should have media api type = FLICKR_PHOTO" do
    @a.media_api_type.should == Muri::FLICKR_PHOTO
  end  
end

shared_examples_for "Flickr parse set" do
  it_should_behave_like "Flickr parse"
  it "should have media api type = FLICKR_SET" do
    @a.media_api_type.should == Muri::FLICKR_SET
  end    
end

describe "Flickr parse first" do
  before(:all) do
    @a = Muri.parse 'http://www.flickr.com/photos/bananastalktome/2088436532/'
  end
  it_should_behave_like "Flickr parse photo"
  it "should have media id" do
    @a.media_id.should == '2088436532'
  end
  
  it "should have a website" do
    @a.media_website.should == 'http://flic.kr/p/4bxMqq'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '2088436532'
  end  
end
describe "Flickr parse second" do
  before(:all) do
    @a = Muri.parse 'http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg'
  end
  it_should_behave_like "Flickr parse photo"
  it "should have media id" do
    @a.media_id.should == '2088436532'
  end
  
  it "should have a website" do
    @a.media_website.should == 'http://flic.kr/p/4bxMqq'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '2088436532'
  end  
  it "should have media thumbnail" do
    @a.media_thumbnail.should == 'http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_t.jpg'
  end
end

describe "Flickr parse set first" do
  before(:all) do
    @a = Muri.parse 'http://www.flickr.com/photos/bananastalktome/sets/72157623467777820/'
  end
  it_should_behave_like "Flickr parse set"
  
  it "should have media id" do
    @a.media_id.should == '72157623467777820'
  end
  
  it "should have a website" do
    @a.media_website.should == 'http://www.flickr.com/photos/bananastalktome/sets/72157623467777820'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '72157623467777820'
  end
end

