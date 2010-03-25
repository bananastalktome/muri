require 'lib/muri.rb'
shared_examples_for "Youtube parse" do
  it "should be Youtube service" do
    @a.media_service.should == 'Youtube'
  end
  
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Youtube parse single" do
  it_should_behave_like "Youtube parse"
  
  it "should have media api type = YOUTUBE_VIDEO" do
    @a.media_api_type.should == Muri::YOUTUBE_VIDEO
  end
end

shared_examples_for "Youtube parse playlist" do
  it_should_behave_like "Youtube parse"
  
  it "should have media api type = YOUTUBE_PLAYLIST" do
    @a.media_api_type.should == Muri::YOUTUBE_PLAYLIST
  end  
end

describe "Youtube parse first" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&'
  end
  it_should_behave_like "Youtube parse single"

  it "should have media id" do
    @a.media_id.should == '4CYDFoEz8rg'
  end
  
  it "should have media api id" do
    @a.media_api_id.should == '4CYDFoEz8rg'
  end
  
  it "should have media url" do
    @a.media_website.should == 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  
  it "should have website" do
    @a.media_url.should == 'http://www.youtube.com/v/4CYDFoEz8rg'
  end
  
  it "should have thumbnail" do
    @a.media_thumbnail.should == 'http://i.ytimg.com/vi/4CYDFoEz8rg/default.jpg'
  end  
end
describe "Youtube parse second" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  it_should_behave_like "Youtube parse single"

  it "should have media id" do
    @a.media_id.should == '4CYDFoEz8rg'
  end
  
  it "should have media api id" do
    @a.media_api_id.should == '4CYDFoEz8rg'
  end
  
  it "should have media url" do
    @a.media_website.should == 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  
  it "should have website" do
    @a.media_url.should == 'http://www.youtube.com/v/4CYDFoEz8rg'
  end
  
  it "should have thumbnail" do
    @a.media_thumbnail.should == 'http://i.ytimg.com/vi/4CYDFoEz8rg/default.jpg'
  end  
end

describe "Youtube parse playlist first" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/p/57633EC69B4A10A2&hl=en_US&fs=1'
  end
  it_should_behave_like "Youtube parse playlist"
  it "should have media id" do
    @a.media_id.should == '57633EC69B4A10A2'
  end
  
  it "should have media api id" do
    @a.media_api_id.should == '57633EC69B4A10A2'
  end
  
  it "should have media url" do
    @a.media_website.should == 'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2'
  end
  
  it "should have website" do
    @a.media_url.should == 'http://www.youtube.com/p/57633EC69B4A10A2'
  end  
end

describe "Youtube parse playlist second" do
  before(:all) do
    @a = Muri.parse 'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2'
  end
  it_should_behave_like "Youtube parse playlist"
  it "should have media id" do
    @a.media_id.should == '57633EC69B4A10A2'
  end
  
  it "should have media api id" do
    @a.media_api_id.should == '57633EC69B4A10A2'
  end
  
  it "should have media url" do
    @a.media_website.should == 'http://www.youtube.com/view_play_list?p=57633EC69B4A10A2'
  end
  
  it "should have website" do
    @a.media_url.should == 'http://www.youtube.com/p/57633EC69B4A10A2'
  end  
end
