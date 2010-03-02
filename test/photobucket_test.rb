require 'lib/muri.rb'

shared_examples_for "Photobucket parse" do
  it "should be Photobucket service" do
    @a.service == 'Photobucket'
  end
end
describe "Photobucket parse first" do
  before(:all) do
    @a = Muri.parse 'http://i244.photobucket.com/albums/gg17/pbapi/file.jpg'
  end
  it_should_behave_like "Photobucket parse"
      
  it "should have media id" do
    @a.media_id == 'file'
  end
  
  it "should have content type" do
    @a.content_type == "jpg"
  end
  
  it "should have media url" do
    @a.website == "http://s244.photobucket.com/albums/gg17/pbapi/?action=view&current=file.jpg"
  end
  
  it "should have website" do
    @a.media_url == "http://i244.photobucket.com/albums/gg17/pbapi/file.jpg"
  end
    
  it "should have media api id" do
    @a.media_api_id == "http://s244.photobucket.com/albums/gg17/pbapi/?action=view&current=file.jpg"
  end
    
  it "should have media thumbnail" do
    @a.media_thumbnail == 'http://mobth244.photobucket.com/albums/gg17/pbapi/file.jpg'
  end
end
describe "Photobucket parse second" do
  before(:all) do
    @a = Muri.parse 'http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg'
  end
  it_should_behave_like "Photobucket parse"
    
  it "should have media id" do
    @a.media_id == 'DSCF0015-1-1'
  end
  
  it "should have content type" do
    @a.content_type == "jpg"
  end
  
  it "should have media url" do
    @a.website == "http://gs0006.photobucket.com/groups/0006/G5PAK3TBQS/?action=view&current=DSCF0015-1-1.jpg"
  end
  
  it "should have website" do
    @a.media_url == "http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg"
  end
  
  it "should have media thumbnail" do
    @a.media_thumbnail == 'http://mobth0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg'
  end
  
  it "should have media api id" do
    @a.media_api_id == "http://gs0006.photobucket.com/groups/0006/G5PAK3TBQS/?action=view&current=DSCF0015-1-1.jpg"
  end
end