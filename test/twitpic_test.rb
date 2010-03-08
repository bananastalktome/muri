require 'lib/muri.rb'
shared_examples_for "Twitpic parse" do
  it "should be Twitpic service" do
    @a.service == 'Twitpic'
  end
  it "should be valid" do
    @a.valid? == true
  end
end

shared_examples_for "Twitpic parse photo" do
  it_should_behave_like "Twitpic parse"
  it "should have media api type = TWITPIC_PHOTO" do
    @a.media_api_type == Muri::TWITPIC_PHOTO
  end  
end

describe "Twitpic parse first" do
  before(:all) do
    @a = Muri.parse 'http://twitpic.com/17d7th'
  end
  it_should_behave_like "Twitpic parse photo"
  it "should have media id" do
    @a.media_id == '17d7th'
  end
  
  it "should have a website" do
    @a.website == "http://twitpic.com/17d7th"
  end
   
  it "should have media api id" do
    @a.media_api_id == '17d7th'
  end  
  
  it "should have media url" do
    @a.media_url == "http://twitpic.com/show/large/17d7th"
  end
  
  it "should have a media thumbnail" do
    @a.media_thumbnail == "http://twitpic.com/show/thumb/17d7th"   
  end
end
