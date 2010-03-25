require 'lib/muri.rb'

shared_examples_for "Vimeo parse" do
  it "should be Vimeo service" do
    @a.media_service.should == 'Vimeo'
  end
  
  it "should be valid" do
    @a.valid?.should == true
  end

end

shared_examples_for "Vimeo parse video" do
  it_should_behave_like "Vimeo parse"
  
  it "should have media api type = VIMEO_VIDEO" do
    @a.media_api_type.should == Muri::VIMEO_VIDEO
  end   
end
shared_examples_for "Vimeo parse album" do
  it_should_behave_like "Vimeo parse"
  
  it "should have media api type = VIMEO_ALBUM" do
    @a.media_api_type.should == Muri::VIMEO_ALBUM
  end   
end

describe "Vimeo parse first" do
  before(:all) do
    @a = Muri.parse 'http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1'
  end
  it_should_behave_like "Vimeo parse video"
  
  it "should have media id" do
    @a.media_id.should == '7312128'
  end
  
  it "should have a website" do
    @a.media_website.should == 'http://vimeo.com/7312128'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '7312128'
  end
end

describe "Vimeo parse second" do
  before(:all) do
    @a = Muri.parse 'http://vimeo.com/7312128'
  end
  it_should_behave_like "Vimeo parse video"
  
  it "should have media id" do
    @a.media_id.should == '7312128'
  end
  
  it "should have a website" do
    @a.media_website.should == 'http://vimeo.com/7312128'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '7312128'
  end
end

describe "Vimeo parse album first" do
  before(:all) do
    @a = Muri.parse 'http://vimeo.com/album/89702'
  end
  it_should_behave_like "Vimeo parse album"
  
  it "should have media id" do
    @a.media_id.should == '89702'
  end

  it "should have a website" do
    @a.media_website.should == 'http://vimeo.com/album/89702'
  end
   
  it "should have media api id" do
    @a.media_api_id.should == '89702'
  end  
end
