require 'lib/muri.rb'

shared_examples_for "Imageshack parse" do
  it "should be Imageshack service" do
    @a.service.should == 'Imageshack'
  end
  it "should be valid" do
    @a.valid?.should == true
  end
end

describe "Imageshack parse first" do
  before(:all) do
    @a = Muri.parse 'http://img178.imageshack.us/i/dsc01576lo7.jpg/'
  end
  it_should_behave_like "Imageshack parse"
  
  it "should have media id" do
    @a.media_id.should == 'dsc01576lo7'
  end
  
  it "should have website" do
    @a.website.should == 'http://img178.imageshack.us/i/dsc01576lo7.jpg/'
  end
   
  it "should have content_type" do
    @a.content_type.should == 'jpg'
  end  
end
describe "Imageshack parse second" do
  before(:all) do
    @a = Muri.parse 'http://img178.imageshack.us/img178/773/dsc01576lo7.jpg'
  end
  it_should_behave_like "Imageshack parse"
  
  it "should have media id" do
    @a.media_id.should == 'dsc01576lo7'
  end
  
  it "should have website" do
    @a.website.should == 'http://img178.imageshack.us/i/dsc01576lo7.jpg/'
  end
   
  it "should have content_type" do
    @a.content_type.should == 'jpg'
  end  
  
  it "should have website" do
    @a.media_url.should == 'http://img178.imageshack.us/img178/773/dsc01576lo7.jpg'
  end
end