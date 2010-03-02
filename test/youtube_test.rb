require 'lib/muri.rb'

shared_examples_for "Youtube parse" do
  it "should be Youtube service" do
    @a.service == 'Youtube'
  end
  
  it "should have media id" do
    @a.media_id == '4CYDFoEz8rg'
  end
  
  it "should have media api id" do
    @a.media_api_id == '4CYDFoEz8rg'
  end
  
  it "should have media url" do
    @a.website == 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  
  it "should have website" do
    @a.media_url == 'http://www.youtube.com/v/4CYDFoEz8rg'
  end
  
  it "should have thumbnail" do
    @a.media_thumbnail == 'http://i.ytimg.com/vi/4CYDFoEz8rg/default.jpg'
  end
end
describe "Youtube parse first" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&'
  end
  it_should_behave_like "Youtube parse"
end
describe "Youtube parse second" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  it_should_behave_like "Youtube parse"
end