require 'lib/muri.rb'
shared_examples_for "Twitpic parse" do
  it "should be Twitpic service" do
    @a.media_service.should == 'Twitpic'
  end
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Twitpic parse photo" do
  it_should_behave_like "Twitpic parse"
  it "should have media api type = TWITPIC_PHOTO" do
    @a.media_api_type.should == Muri::TWITPIC_PHOTO
  end  
end
{'http://twitpic.com/17d7th' =>
  { :media_id => '17d7th',
    :media_website => "http://twitpic.com/17d7th",
    :media_api_id => '17d7th',
    :media_url => "http://twitpic.com/show/large/17d7th",
    :media_thumbnail => "http://twitpic.com/show/thumb/17d7th"
  }
}.each do |url, values|
  describe "Twitpic parse #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    it_should_behave_like "Twitpic parse photo"
    
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_website]
      it "should have a website" do
        @a.media_website.should == values[:media_website]
      end
    end
    
    if values[:media_api_id]
      it "should have media api id" do
        @a.media_api_id.should == values[:media_api_id]
      end  
    end
    
    if values[:media_url]
      it "should have media url" do
        @a.media_url.should == values[:media_url]
      end
    end
    
    if values[:media_thumbnail]
      it "should have a media thumbnail" do
        @a.media_thumbnail.should == values[:media_thumbnail]  
      end
    end
  end
end
