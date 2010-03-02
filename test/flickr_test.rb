require 'lib/muri.rb'

shared_examples_for "Flickr parse" do
  it "should be Flickr service" do
    @a.service == 'Flickr'
  end
  
  it "should have media id" do
    @a.media_id == '2088436532'
  end
  
  it "should have media url" do
    @a.website == 'http://flic.kr/p/4bxMqq'
  end
   
  it "should have media api id" do
    @a.media_api_id == '2088436532'
  end
end
describe "Flickr parse first" do
  before(:all) do
    @a = Muri.parse 'http://www.flickr.com/photos/bananastalktome/2088436532/'
  end
  it_should_behave_like "Flickr parse"
end
describe "Flickr parse second" do
  before(:all) do
    @a = Muri.parse 'http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_m.jpg'
  end
  it_should_behave_like "Flickr parse"
  
  it "should have media thumbnail" do
    @a.media_thumbnail == 'http://farm3.static.flickr.com/2178/2088436532_ee07b4474e_t.jpg'
  end
end