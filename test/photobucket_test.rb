require 'lib/muri.rb'

shared_examples_for "Photobucket parse" do
  it "should be Photobucket service" do
    @a.service.should == 'Photobucket'
  end
  
  it "should be valid" do
    @a.valid?.should == true
  end
  
  it "should have media api type = PHOTOBUCKET_MEDIA" do
    @a.media_api_type.should == Muri::PHOTOBUCKET_MEDIA
  end
end

describe "Photobucket parse first" do
  before(:all) do
    @a = Muri.parse 'http://i244.photobucket.com/albums/gg17/pbapi/file.jpg'
  end
  it_should_behave_like "Photobucket parse"
      
  it "should have media id" do
    @a.media_id.should == 'file'
  end
  
  it "should have content type" do
    @a.content_type.should == "jpg"
  end
  
  it "should have a website" do
    @a.website.should == "http://s244.photobucket.com/albums/gg17/pbapi/?action=view&current=file.jpg"
  end
  
  it "should have media url" do
    @a.media_url.should == "http://i244.photobucket.com/albums/gg17/pbapi/file.jpg"
  end
    
  it "should have media api id" do
    @a.media_api_id.should == "http://i244.photobucket.com/albums/gg17/pbapi/file.jpg"
  end
    
  it "should have media thumbnail" do
    @a.media_thumbnail.should == 'http://mobth244.photobucket.com/albums/gg17/pbapi/file.jpg'
  end
end

describe "Photobucket parse second" do
  before(:all) do
    @a = Muri.parse 'http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg'
  end
  it_should_behave_like "Photobucket parse"
    
  it "should have media id" do
    @a.media_id.should == 'DSCF0015-1-1'
  end
  
  it "should have content type" do
    @a.content_type.should == "jpg"
  end
  
  it "should have a website" do
    @a.website.should == "http://gs0006.photobucket.com/groups/0006/G5PAK3TBQS/?action=view&current=DSCF0015-1-1.jpg"
  end
  
  it "should have media url" do
    @a.media_url.should == "http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg"
  end
  
  it "should have media thumbnail" do
    @a.media_thumbnail.should == 'http://mobth0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg'
  end
  
  it "should have media api id" do
    @a.media_api_id.should == "http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg"
  end
end
