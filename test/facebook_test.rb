require 'lib/muri.rb'

shared_examples_for "Facebook parse" do
  it "should be Facebook service" do
    @a.service == 'Facebook'
  end

  it "should be valid" do
    @a.valid? == true
  end
end
shared_examples_for "Facebook parse photo" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_PHOTO" do
    @a.media_api_type == Muri::FACEBOOK_PHOTO
  end
end

shared_examples_for "Facebook parse video" do
  it_should_behave_like "Facebook parse"
  it "should have media api type = FACEBOOK_VIDEO" do
    @a.media_api_type == Muri::FACEBOOK_VIDEO
  end
end

describe "Facebook parse first" do
  before(:all) do
    @a = Muri.parse 'http://www.facebook.com/v/614695029223'
  end
  it_should_behave_like "Facebook parse video"
  
  it "should have media id" do
    @a.media_id == '614695029223'
  end
  
  it "should have a media_url" do
    @a.website == 'http://www.facebook.com/v/614695029223'
  end
   
  it "should have media api id" do
    @a.media_api_id == '614695029223'
  end
end

describe "Facebook parse second" do
  before(:all) do
    @a = Muri.parse 'http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063'
  end
  it_should_behave_like "Facebook parse photo"

  it "should have media id" do
    @a.media_id == '34929102'
  end
  
  it "should have a website" do
    @a.website == 'http://www.facebook.com/photo.php?pid=34929102&l=a1abf8cd37&id=15201063'
  end
   
  it "should have media api id" do
    @a.media_api_id == '65288068484364750'
  end  
end